# -*- coding: utf-8 -*-
require './bookdesc'

workdir = "~/amazonrank"
htmlfile = workdir.dup << "/index.html"
isbnfile = "ISBN.txt"

open(htmlfile, "w") { |f|
  f.print <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title>Amazonランキング</title>
</head>

<body>
<h1>Amazonランキング</h1>
<ul>
EOS

  open(isbnfile, "r") { |lines|
    while l = lines.gets
      l = l.chomp
      f.print "<li><a href=\"", l, ".html\">"
      f.bookdesc(l)
      f.print "</a> <a href=\"http://www.amazon.co.jp/dp/", l, "\">Amazon</a></li>\n"
    end
  }
  f.print <<EOS
</ul>
</body>
</html>
EOS
}
