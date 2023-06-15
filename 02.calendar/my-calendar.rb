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

printf("      \e[31m%d\e[0m月 \e[31m%d\e[0m     \n", display_date.month, display_date.year)
puts '日 月 火 水 木 金 土'

(1..display_date.mday).each do |date|
  printf("\e[31m%2d \e[0m", date)
  puts "\n" if (date % 7).zero?
end
