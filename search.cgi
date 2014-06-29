#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
require 'xml/xslt'
xslt = XML::XSLT.new()
xslt.xml = "xml"
xslt.xsl = "list.xsl"
cgi = CGI.new
if cgi["query"].length > 0 then
  xslt.parameters = {"search" => true.to_s,
    "query" => cgi["query"],
    "title" =>cgi["title"],
    "creator" =>cgi["creator"],
    "publisher" =>cgi["publisher"],
	"price" =>cgi["price"],
    "isbn" =>cgi["isbn"],
    "url" =>cgi["url"],
    "keyword" =>cgi["keyword"],
    "description" =>cgi["description"],
    "order" =>cgi["order"]
}
else
  xslt.parameters = {"search" => false.to_s,"query" => "",
    "title" =>"off",
    "creator" =>"off",
    "publisher" =>"off",
    "price" =>"off",
    "isbn" =>"off",
    "url" =>"off",
    "keyword" =>"off",
    "description" =>"off",
    "order" =>"off"}
end
out = xslt.serve()
print cgi.header("text/html; charset=UTF-8")
print out
