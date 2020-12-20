#!/usr/bin/ruby
require 'date'
require 'optparse'

options = ARGV.getopts('m:y:')
year = options["y"]
month = options["m"]

if year && month
  puts "　　　　#{month}月　#{year}"
  puts "日　月　火　水　木　金　土"
  first_day = Date.parse("#{year}-#{month}-1")
  final_day = Date.new(year.to_i, month.to_i, -1)
  second_day = Date.parse("#{year}-#{month}-2")
else
  today = Date.today.to_s.split("-")
  this_year = today[0]
  this_month = today[1]
  first_day = Date.parse("#{this_year}-#{this_month}-1")
  final_day = Date.new(this_year.to_i, this_month.to_i, -1)
  second_day = Date.parse("#{this_year}-#{this_month}-2")
  puts "　　　　#{this_month}月 #{this_year}"
  puts "日　月　火　水　木　金　土"
end

days_array = []
if first_day.monday?
  days_array.push("     #{first_day.day}")
elsif first_day.tuesday?
  days_array.push("         #{first_day.day}")
elsif first_day.wednesday?
  days_array.push("             #{first_day.day}")
elsif first_day.thursday?
  days_array.push("                 #{first_day.day}")
elsif first_day.friday?
  days_array.push("                     #{first_day.day}")
elsif first_day.saturday?
  days_array.push("                         #{first_day.day}\n")
else first_day.sunday?
  days_array.push("#{first_day.day}　")
end

days = (second_day..final_day)  
days.each do |day|
  if day.saturday?
    days_array.push("#{day.day}\n")
  else
    days_array.push("#{day.day} ")
  end
end

days_array.each do |day|
  if day.to_i > 0 && day.to_i < 10
    print(" #{day} ")
  else
    print("#{day} ")
  end
end
