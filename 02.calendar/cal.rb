#! /usr/bin/env ruby
require 'date'
require 'optparse'

params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

month_year = [params["m"] + "月", params["y"]]
days_of_the_week = ["日", "月", "火", "水", "木", "金", "土"]

6.times {print " "} 
puts month_year.join(" ")
puts days_of_the_week.join(" ")

first_day = Date.new(params["y"].to_i, params["m"].to_i, 1)
last_day = Date.new(params["y"].to_i, params["m"].to_i, -1) 

def blank(x)
  (x * 3).times {print " "}
end

blank(first_day.wday)

(first_day..last_day).each do |date|
  if "#{date.day}".length == 1
    print " "
  end
  print date.day
  print " "
  if date.wday == 6
    puts "\n"
  end
end

print "\n"

