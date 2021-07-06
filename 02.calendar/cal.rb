#!/usr/bin/env ruby

require "date"
require 'optparse'

opt = OptionParser.new
params = ARGV.getopts("y:", "m:")
if params["y"] == nil && params["m"] == nil
  year = Date.today.year
  month = Date.today.month
elsif params["y"] == nil
  year = Date.today.year
  month = params["m"].to_i
elsif params["m"] == nil
  year = params["y"].to_i
  month = Date.today.month
else
  year = params["y"].to_i
  month = params["m"].to_i
end

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
puts "#{first_day.month}月 #{first_day.year}".center(20)
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

(first_day..last_day).each do |range_day|
  if range_day.day == 1 && range_day.wday == 6
    (3 * range_day.wday).times do
      print " "
    end
    print " #{range_day.day}\n"
  elsif range_day.day == 1
    (3 * range_day.wday).times do
      print " "
    end
    print " #{range_day.day} "
  elsif range_day.day.to_s.length == 1 && range_day.wday == 6 
    print " #{range_day.day}\n"
  elsif range_day.day.to_s.length == 1
    print " #{range_day.day} "
  elsif range_day.wday == 6
    print "#{range_day.day}\n"
  elsif range_day.day == last_day.day
    print "#{range_day.day}\n"
  else
    print range_day.day
    print " "
  end
end
