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

display_date = Date.new(display_year, display_month, -1)

printf("      %s %d     \n", display_date.strftime("%B"), display_date.year)
puts 'Su Mo Tu We Th Fr Sa'

(1..display_date.mday).each do |date|
  printf("%2d ", date)
  puts "\n" if (date % 7).zero?
end
