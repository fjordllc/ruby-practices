#!/usr/bin/env ruby

require 'optparse'
require 'date'

option ={}
OptionParser.new do |opt|
  opt.on('-m value'){|n| option[:m] = n}
  opt.on('-y value'){|n| option[:y] = n}
  opt.parse!(ARGV)
end

if option[:y]
    year = option[:y].to_i
else
    year = Date.today.year
end

if option[:m]
  month = option[:m].to_i
else
  month = Date.today.month
end


puts "#{month}月 #{year}年".center(20)

puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

# year = Date.today.year
# mon = Date.today.mon
firstday_wday = Date.new(year,month,1).wday
lastday_date = Date.new(year,month,-1).day
wday = firstday_wday

print "   " * firstday_wday

(1..lastday_date).each do |date|
  print date.to_s.rjust(2) + " "
  wday += 1
  if wday % 7 == 0
    print "\n"
  end
end
