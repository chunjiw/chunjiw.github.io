using Printf


function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end


function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end


function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end


"""
    {{ listposts }}
Plug in the list of blog posts contained in folder `category`.
"""
function hfun_listposts(categoryvector)
    category = categoryvector[1]
    io = IOBuffer()
    base = joinpath(category)
    posts = filter!(p -> endswith(p, ".md"), readdir(base))
    dates  = Vector{Date}(undef, length(posts))
    lines = Vector{String}(undef, length(posts))
    for (i, post) in enumerate(posts)
        ps  = splitext(post)[1]
        url = "/$category/$ps/"
        surl = strip(url, '/')
        title = pagevar(surl, :title)
        date = pagevar(surl, :date)
        dates[i] = date
        showdate = category == "chinese" ?
          @sprintf("%i月%i日", month(date), day(date)) :
          Dates.format(date, "u d")
        lines[i] = """~~~
          <span class="post-date">$showdate</span>~~~
          [$title]($url) \n
        """
    end
    # sort by day
    foreach(line -> write(io, line), lines[sortperm(dates, rev=true)])
    # markdown conversion adds `<p>` beginning and end but
    # we want to  avoid this to avoid an empty separator
    r = Franklin.fd2html(String(take!(io)), internal=true)
    return r
end
