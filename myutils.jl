# Want to include this to run somewhere
# not perfect to run it in config.md, because need to parse julia code out from md.

categories = [("chinese", "中文"),
              ("english", "English")]

function generate_category_index(categories)
    for (dir, cat) in categories
        open("$dir.md", "w") do io
        write(io, """@def title = "$cat"\n""")
        write(io, """@def date = ""\n""")
        write(io, "{{ listposts $dir }}")
        end
    end
end
generate_category_index(categories)
