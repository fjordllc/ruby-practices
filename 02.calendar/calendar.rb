#!/usr/bin/env ruby

require 'date'
require 'optparse'

opt = OptionParser.new
options = {}

opt.on('-m [month]') {|m| options[:m] = m }
opt.on('-y [year]') {|y| options[:y] = y }

opt.parse(ARGV)

today = Date.today
get_year = today.year
get_month = today.month

if options[:y]
  get_year = options[:y].to_i
end

if options[:m]
  get_month = options[:m].to_i
end

beginning_of_month = Date.new(get_year, get_month, 1)
end_of_month = Date.new(get_year, get_month, -1)

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
