<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Chunji Wang"
mintoclevel = 2

ignore = ["node_modules/"]

generate_rss = true
website_title = "CW Site"
website_descr = "CW Site Description"
website_url   = "https://tlienart.github.io/FranklinTemplates.jl/"

categories = [("chinese", "中文"),
              ("english", "English")]

function generate_category_index(categories)
  for (dir, cat) in categories
    open("$dir.md", "w") do io
      write(io, """@def title = "$cat"\n""")
      write(io, "{{ listposts $dir }}")
    end
  end
end
generate_category_index(categories)


+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
