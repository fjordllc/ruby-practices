#!/usr/bin/env ruby

require 'date'
require 'optparse'

opt = OptionParser.new
options = {}

opt.on('-m [month]') {|m| options[:m] = m }
opt.on('-y [year]') {|y| options[:y] = y }

opt.parse(ARGV)

today = Date.today

option_month = options[:m].to_i if options[:m]
option_year = options[:y].to_i if options[:y]

if option_year && option_month
  beginning_of_month = Date.new(option_year, option_month, 1)
  end_of_month = Date.new(option_year, option_month, -1)
elsif option_month
  beginning_of_month = Date.new(today.year, option_month.to_i, 1)
  end_of_month = Date.new(today.year, option_month, -1)
elsif option_year
  beginning_of_month = Date.new(option_year, today.month, 1)
  end_of_month = Date.new(option_year, today.month, -1)
else
  beginning_of_month = Date.new(today.year, today.month, 1)
  end_of_month = Date.new(today.year, today.month, -1)
end

firstday_wday = beginning_of_month.wday

puts "      #{beginning_of_month.month}月 #{beginning_of_month.year}"

week = ["日", "月", "火", "水", "木", "金", "土"]

week.each do |day|
  print day + " "
end
print "\n"
print "   " * firstday_wday

(1..end_of_month.day).each do |day|
  date = Date.new(beginning_of_month.year, beginning_of_month.month, day)
  print day.to_s.rjust(2)
  print " "
  if date.wday == 6
    print "\n"
  end

end
print "\n"
