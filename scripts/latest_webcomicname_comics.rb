#!/usr/bin/env ruby

require 'rss'
require 'open-uri'
require 'nokogiri'

url = 'https://webcomicname.com'

html = Nokogiri::HTML(open(url).read)
(html/'.tmblr-full img').each do |img|
  puts img.attribute('src')
end

