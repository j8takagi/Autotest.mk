# -*- coding: utf-8 -*-
require 'amazon/aws/search'
include Amazon::AWS
workdir = File.expand_path("~/amazonrank")

begin
  il = ItemLookup.new( 'ASIN', { 'ItemId' => ARGV[0] } )
  request  = Search::Request.new
  time  = Time.now.strftime("%Y/%m/%d %H:%M:%S")
  req = request.search il
  rank = req.item_lookup_response.items.item.sales_rank
  raise "ランキングを取得できませんでした。原因不明" if req.nil?
  csvfile = File.expand_path(workdir.dup << "/" << ARGV[0].dup <<  ".csv")
  open(csvfile, "a") { |f|
    f.print ARGV[0], ",", time, ",", req, "\n"
  }
rescue => exc
  STDERR.puts exc
  errfile = File.expand_path(workdir.dup << "/error.log")
  open(errfile, "a") { |f|
    f.print "エラー: ", exc, "\n"
    f.print "ASBN: ", ARGV[0], "\n"
    f.print "日時: ", time, "\n"
    f.print "\n"
  }
end
