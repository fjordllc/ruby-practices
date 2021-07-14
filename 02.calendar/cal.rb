#!/usr/bin/env ruby

require "date"
require 'optparse'

params = ARGV.getopts("y:", "m:")
if params["y"] == nil
  year = Date.today.year
else
  year = params["y"].to_i
end

if params["m"] == nil
  month = Date.today.month
else
  month = params["m"].to_i
end

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
puts "#{first_day.month}月 #{first_day.year}".center(20)
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

(first_day..last_day).each do |range_day|
  if range_day.day == 1
    (3 * range_day.wday).times do
      print " "
    end
  end
  print "#{range_day.day.to_s.rjust(2)} "
  if range_day.wday == 6
    print "\n"
  end
  if range_day.day == last_day.day
    print "\n"
  end
end
