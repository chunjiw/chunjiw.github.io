@def title = "Add a customized font to your Franklin website"
@def date = Date(2021, 9, 16)

\toc

## Foreword

You probably want to use a customized font for your website eventually.
I have Chinese content on this site, and I [don't like](/chinese/fall-of-kai-font) the default font for Chinese, so I have to use a customized one.

This can be achieved using web font, e.g. a font from Google font.
For concern of the availability of Google in mainland China, I decided to skip Google and use my own.

Here I show how to do it for a [Franklin](https://franklinjl.org) site, but it is easy to adapt to your specific SSG.

## Obtain your font

Search and download some free font.
If you design your own font, then you probably will not learn anything new here.

I downloaded a "True Type" font from [here](https://chinesefonts.org/fonts/fzfangsong-z02s-regular); 
it is a single file with extention `.ttf`.
Many articles online recommand [this](https://www.fontsquirrel.com/tools/webfont-generator) webfont generator from [Font Squirrel](https://www.fontsquirrel.com/) to convert format and generate css; 
it is very convienient, but I found it removing the Chinese font in my font file, only keeping the English alphabet. 
Maybe I didn't use the correct setting. 
Check [here](https://www.w3schools.com/cssref/css3_pr_font-face_rule.asp) to decide what format you want to use.

Put the file in `_css` folder.

## CSS @font-face

Create a file `fonts.css` in `_css` folder with this content:

```css
@font-face {
    font-family: fzfangsong-z02sregular;
    src: url(fzfangsong-z02sregular.ttf) format('truetype');
}
```

It's not necessary to put quotes around the file name in `url()`.
In fact it is better if you don't, which forces you not to have spaces in the file name.
If you have spaces in the file name and you put quotes around it like `url('my font.fft')`,
then your site would be rendered correctly locally, but not after Github action, because Github action somehow removes the quote marks and the font file would not be loaded.

I found this out after hours of wrestling with my code. 
I eventually discovered the difference by checking the site sources with the browser's "inspect" feature.


This new file has to be added to template layout.
Locate `_layout/head.html` and add this line to the file:
```html
  <link rel="stylesheet" href="/css/fonts.css">
```


## Use the new font

Use the new font by referring to it in other css files.
I added it to `franklin.css`:
```css
html {
    font-family: Helvetica, Arial, sans-serif, fzfangsong-z02sregular;
    ...
}
```

That's all there is to it!