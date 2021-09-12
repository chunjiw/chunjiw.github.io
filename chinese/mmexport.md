@def title = "用 Bash 自动添加日期时间到微信图片"
@def date = Date(2021, 9, 11)

\toc

## 缘起

用安卓手机保存微信图片之后，图片的内嵌信息比如拍摄时间地点会被全部删除掉，
文件名也被改为类似于 `mmexport1620967280xxx.jpg` 。
这样会导致某些图片管理器无法获得图片拍摄时间，以至于无法把这张图片显示在时间线上合适的位置。

之前用谷歌照片的时候，谷歌会假设上传时间是拍摄时间，八九不离十；
但是现在我用的 Photoprism，虽然会根据图片文件修改时间来决定把图片保存在哪里，但却不会认为这个时间是拍摄时间，导致不能在日历中显示此图片。

## 日期时间信息还在么

经过长时间的摸索，我发现其实微信图片的文件名中 `mmexport` 之后的数字是所谓的 [Epoch time](https://www.epochconverter.com/) (aka Unix epoch, Unix time, POSIX time or Unix timestamp)，从中可以计算出图片生成时间，就是在微信 App 上点保存图片的时间。
虽然不是拍摄时间，但是，哎，八九不离十。

## 添加与编辑图片内嵌的日期时间数据：Exif

Exif 是常见的图片内嵌数据格式标准。
很多工具可以编辑 Exif。
我的第一反应是写几行 Julia 代码来添加 Exif
```julia
using ImageMagick
using Dates

function exifdt(file)
	tag = "exif:DateTime"
	ImageMagick.magickinfo(file, tag)[tag]
end

function namedt(file)
	s = round(Int, parse(Int, file[end-16:end-4]) / 1000)
	dt = unix2datetime(s)
	str = Dates.format(dt, "yyyy:mm:dd HH:MM:SS")
end

run(`exif $file --ifd 0 --tag DateTimeOriginal --set-value $(namedt(file))`)
run(`exiftool "-DateTimeOriginal=$(namedt(file))" $file`)
```
明眼人可以看到，这段代码最后调用了其他工具来编辑 Exif：
exif 和 exiftool。两个都挺好用。
Julia 在这里只是把 Epoch time 转成年月日的作用，感觉杀鸡用牛刀。

## Bash 入场

同样的事情完全可以用 Bash 来做。
用 Bash 的好处是几乎任何 Linux Machine 都有它，不用安装额外的软件。
最终代码如下：
```bash
exifdt=$(exif "$DIR$FILE" -t "Date and Time")
if [ -z "$exifdt" ]; then
    echo "This image has no exif"
    unixtime="${FILE:8:10}"
    echo "unixtime from file name is $unixtime"
    DATETIME=$(date -d @"$unixtime" "+%4Y:%m:%d %T")
    echo "corresponding UTC is $DATETIME"
    exif "$DIR$FILE" --ifd 0 --tag 0x132 --set-value "$DATETIME" -c --output "$PROCESSED_DIR""$FILE"
    rm "$DIR$FILE"
else
    mv "$DIR$FILE" "$PROCESSED_DIR$FILE"
    echo "Already have DateTime in exif, directly move to processed folder"
fi
unset exifdt
```
看着有点长，重要的只有两句：

```bash
# 查看图片有没有时间日期
exif "$DIR$FILE" -t "Date and Time"
# 如果没有，添加时间日期
exif "$DIR$FILE" --ifd 0 --tag 0x132 --set-value "$DATETIME" -c --output "$PROCESSED_DIR""$FILE"
```
另外重要的一句是
```bash
# 根据文件名产生符合 Exif 格式的时间日期字符串
date -d @"$unixtime" "+%4Y:%m:%d %T"
```

## 用 inotify 自动执行 Bash 脚本
虽然有 Bash 脚本，如果每次手动运行，太不方便。
需要做的是每当有新图片被保存，就对其做处理。
幸运的是 Linux 有一个很方便的工具 inotifytools，每当指定的文件或文件夹有什么风吹草动，它会释放信号。
inotifytools 提供两个功能：inotifywait 和 inotifywatch，侧重不同，这里用 inotifywait。这个命令能输出指定的信息，帮助运行上面的 Bash 脚本：
```bash
#!/bin/bash

PROCESSED_DIR=/your/processed/directory/

inotifywait -m --timefmt '%m/%d/%y %H:%M:%S' --format '%T %w %f %e'\
  --include mmexport[0-9]+ \
  -e attrib \
  /your/unprocessed/directory/ |

while read -r DATE_NOT_USED TIME_NOT_USED DIR FILE EVENT; do
    mkdir -p "$PROCESSED_DIR"
    echo
    echo "File $DIR$FILE has event $EVENT"
    sleep 5
    exifdt=$(exif "$DIR$FILE" -t "Date and Time")
    if [ -z "$exifdt" ]; then
        echo "This image has no exif"
        unixtime="${FILE:8:10}"
        echo "unixtime from file name is $unixtime"
        DATETIME=$(date -d @"$unixtime" "+%4Y:%m:%d %T")
        echo "corresponding UTC is $DATETIME"
        exif "$DIR$FILE" --ifd 0 --tag 0x132 --set-value "$DATETIME" -c --output "$PROCESSED_DIR""$FILE"
        rm "$DIR$FILE"
    else
        mv "$DIR$FILE" "$PROCESSED_DIR$FILE"
        echo "Already have DateTime in exif, directly move to processed folder"
    fi
    unset exifdt

    /usr/local/bin/docker-compose -f /path/to/docker-compose.yml exec -T photoprism photoprism import
done

# event type that I didn't use:
# -e close_write 
# -e close -e moved_to 
```

好啦，这下我每次保存微信图片后，这个脚本会自动运行，照片会自动显示在 Photoprism 中时间线上正确的位置。

## 更多

- 创建 systemd unit 用来开机自动运行脚本