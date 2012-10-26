# -*- coding: utf-8 -*-
require './bookdesc'

workdir = "~/amazonrank"
htmlfile = workdir.dup << "/" << ARGV[0].dup <<  ".html"

open(htmlfile, "w") { |f|
  f.print <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
EOS
  f.print "<title>Amazonランキング - ", ARGV[0], "</title>\n"

  f.print <<EOS
</head>
<body>
EOS

  f.print "<h1>Amazonランキング - ASBN", ARGV[0], "</h1>"
  f.print "<p>"
  f.bookdesc(ARGV[0])
  f.print "</p>\n"
  f.print "<p><a href=\"http://www.amazon.co.jp/dp/", ARGV[0], "\">Amazonのページ</a></p>\n"
  f.print "<p><a href=\"", ARGV[0], ".csv\">データファイル（CSV形式）</a></p>\n"
  f.print "<p><a href=\"", ARGV[0], "r.html\">グラフの上下を逆にする</a></p>\n"

  f.print <<EOS
<p><a href=\"index.html\">目次へ戻る</a></p>
<div>
EOS

  f.print "<object data=\"", ARGV[0], ".svg\" type=\"image/svg+xml\" width=\"772.70\" height=\"578.16\">\n"
  f.print "<img src=\"", ARGV[0], ".png\" alt=\"", ARGV[0], "のランキング\" />\n"

  f.print <<EOS
</object>
</div>
</body>
</html>
EOS
}
