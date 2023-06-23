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
puts 'Su Mo Tu We Th Fr Sa'

first_day_wday = first_day.wday
blank = '   ' * first_day_wday
print blank

(1..last_day.mday).each_with_index do |date, i|
  printf("%2d ", date)
  puts "\n" if ((first_day_wday + date) % 7).zero? || i == last_day.mday - 1
end
