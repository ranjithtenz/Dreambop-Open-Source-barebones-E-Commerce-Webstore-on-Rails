#!/usr/bin/env ruby
require 'net/ftp'
all_prods = `/path/to/dreambop/script/xml/all_products.rb > output.xml`
ftp = Net::FTP.new('uploads.google.com')
ftp.login('thedude', 'whiterussian')
ftp.putbinaryfile('output.xml', 'feed.xml')
File.delete('/path/to/dreambop/script/xml/output.xml')
ftp.close
