#!/usr/bin/env ruby

require 'optparse'
require 'date'

display_year = Date.today.year
display_month = Date.today.month

OptionParser.new do |options|
  options.on("-y YEAR", Integer) do |year|
    display_year = year
  end

  options.on("-m MONTH", Integer) do |month|
    display_month = month
  end
end.parse!

first_day = Date.new(display_year, display_month, 1)
last_day = Date.new(display_year, display_month, -1)

printf("      %s %d     \n", last_day.strftime("%B"), last_day.year)
puts ' Su Mo Tu We Th Fr Sa'

blank = '   ' * first_day.wday
print blank

(first_day..last_day).each do |date|
  printf(date.day.to_s.rjust(3))
  puts "\n" if date.saturday? || date == last_day
end