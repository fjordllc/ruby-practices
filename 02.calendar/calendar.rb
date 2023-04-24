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
first_date_wday= first_date.wday

puts "       #{month}月 #{year}"
puts " 日 月 火 水 木 金 土"

first_empty_line = first_date.wday * 3
printf "%#{first_empty_line}s",""
(first_date..last_date).each do |date|
  display_day = date.mday.to_s
  if date == today
    printf (" \e[7m#{display_day}\e[0m")
  else  
    printf (display_day.rjust(3))
  end
  puts "" if date.wday == 6
end
