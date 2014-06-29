#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
require 'xml/xslt'
xslt = XML::XSLT.new()
xslt.xml = "xml"
xslt.xsl = "details.xsl"
cgi = CGI.new
xslt.parameters = {"number" => cgi["number"]}
out = xslt.serve()
print cgi.header("text/html; charset=UTF-8")
print out

