# -*- coding: utf-8 -*-
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search

class File
  def bookdesc(isbn)
    look = ItemLookup.new( 'ASIN', { 'ItemId' => isbn } )
    look.response_group = ResponseGroup.new( 'Small' )
    req  = Search::Request.new
    res = req.search(look)
    attr = res.item_lookup_response.items.item.item_attributes
    print attr.author, "『", attr.title, "』（", attr.manufacturer, "）"
  end
end
