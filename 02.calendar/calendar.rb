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
number_of_days =  last_date.mday

puts "       #{month}月 #{year}"
puts " 日 月 火 水 木 金 土"

first_empty_line = first_date_wday * 3
printf "%#{first_empty_line}s",""
(first_date..last_date).each do |date|
  day_of_week = date.wday
  day_empty_line = " " if date.mday < 10
  if date == today
    printf("%s"," #{day_empty_line}\e[7m#{date.mday}\e[0m")
  else  
    printf("%3d",date.mday)
  end
  puts "" if day_of_week == 6
end
