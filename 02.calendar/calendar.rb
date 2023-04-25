#!/usr/bin/env ruby

require 'optparse'
require 'date'

params = ARGV.getopts("m:y:")
today = Date.today
input_month = params["m"].to_i
month = input_month.zero? ? today.month : input_month
input_year = params["y"].to_i
year = input_year.zero? ? today.year : input_year
reference_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
first_date =  Date.new(year, month, 1)

puts "       #{month}月 #{year}"
puts " 日 月 火 水 木 金 土"

padding_size_for_first_date = first_date.wday * 3
print " "  * padding_size_for_first_date,""
(first_date..last_date).each do |date|
  display_day = date.mday.to_s
  if date == today
    print (" \e[7m#{display_day.rjust(2)}\e[0m")
  else  
    print (display_day.rjust(3))
  end
  puts "" if date.wday == 6
end

