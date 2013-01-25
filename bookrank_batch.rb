#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-
require 'amazon/aws/search'
include Amazon::AWS

workdir = File.expand_path("~/amazonrank")
isbnfile = File.expand_path(workdir.dup << "/ISBN.txt")

open(isbnfile, "r") { |lines|
  while isbn = lines.gets
    isbn = isbn.chomp
    csvfile = File.expand_path(workdir.dup << "/" << isbn.dup <<  ".csv")
    il = ItemLookup.new( 'ASIN', { 'ItemId' => isbn } )
    request  = Search::Request.new
    time  = Time.now
    req = request.search il
    open(csvfile, "a") { |f|
      f.print isbn, ",", time.strftime("%Y/%m/%d %H:%M:%S"), ",", req.item_lookup_response.items.item.sales_rank, "\n"
    }
    sleep 0.5
  end
}
