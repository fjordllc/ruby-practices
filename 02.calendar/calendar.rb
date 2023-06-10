#!/usr/bin/env ruby

require 'optparse'
require 'date'

option ={}
OptionParser.new do |opt|
  opt.on('-m value'){|n| option[:m] = n}
  opt.on('-y value'){|n| option[:y] = n}
  opt.parse!(ARGV)
end

year = option[:y] ? option[:y].to_i : Date.today.year

month = option[:m] ? option[:m].to_i : Date.today.month


puts "#{month}月 #{year}年".center(20)

puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

print "   " * Date.new(year,month,1).wday

(1..Date.new(year,month,-1).day).each do |date|
  print date.to_s.rjust(2) + " "
  if Date.new(year, month, date).saturday?
    print "\n"
  end
end
