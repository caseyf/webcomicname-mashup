#!/usr/bin/env ruby

require 'rss'
require 'open-uri'
require 'nokogiri'

url = 'http://webcomicname.com/rss'

open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  feed.items.each do |item|
    html = Nokogiri::HTML.fragment(item.description)
    if (img = html/'img')
      puts img.attribute('src').to_s.gsub(/_(\d+).(jpg|png)$/, '_1280.\2')
    end
  end
end