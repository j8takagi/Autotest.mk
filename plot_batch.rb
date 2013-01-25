#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

# Rプログラムのパス
rpath = "/usr/local/bin/R"

# 作業用ディレクトリのトップ
workdir = File.expand_path("~/amazonrank")

# Rのグラフ出力プログラム
plotfile = workdir.dup << "/plot.R"

# ASINリストファイル
isbnfile = workdir.dup << "/ISBN.txt"

# データCSVファイルを格納するディレクトリ
csvdir = workdir.dup

# HTMLファイルおよびデータCSVファイルを格納するディレクトリ
htmldir = workdir.dup

# プロット時のエラー記録ファイル
ploterrfile = workdir.dup << "/error_plot.log"

open(isbnfile, "r") { |lines|
  begin
    while isbn = lines.gets
      isbn = isbn.chomp
      cmd = rpath.dup << " --vanilla --slave --args " << isbn.dup << " " << csvdir.dup << " " << htmldir.dup << " <" << plotfile.dup << " 2>>" << ploterrfile.dup
      system(cmd)
      raise "ASIN:" << isbn.dup << " コマンド実行エラー" if $? != 0
    end
  rescue => exc
    STDERR.puts exc
    errfile = File.expand_path(ploterrfile.dup)
    open(errfile, "a") { |f|
      f.print "ASIN: ", isbn, "\n"
      f.print "日時: ", Time.now.strftime("%Y/%m/%d %H:%M:%S"), "\n"
      f.print "\n"
    }
    retry
  end
}
