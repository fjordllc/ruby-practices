#!/usr/bin/env ruby

require 'optparse'
require 'date'
params = ARGV.getopts("m:y:")
select_month = params["m"].to_i
select_year = params["y"].to_i
today = Date.today

case
when select_month && select_year != 0
  reference_date = Date.new(select_year,select_month,1)
when (select_month != 0 ) && (select_year == 0)
  reference_date = Date.new(today.year,select_month,1)
else
  reference_date = today
end

display_year = reference_date.year
display_mon = reference_date.mon
reference_day = reference_date.mday
reference_wday = reference_date.wday
firstday = reference_date - reference_day + 1
firstday_wday= firstday.wday
lastday = Date.new(display_year,display_mon,-1)
number_of_days =  lastday.mday

puts "       #{display_mon}月 #{display_year}"
puts " 日 月 火 水 木 金 土"

first_empty_line = firstday_wday * 3
printf "%#{first_empty_line}s",""
(1..number_of_days).each { |day|
  days = Date.new(display_year, display_mon,day)
  day_of_week = days.wday
  day_empty_line = " " if day < 10
  if days == today
    printf("%s"," #{day_empty_line}\e[7m#{day}\e[0m")
  else  
    printf("%3d",day)
  end
  puts "" if day_of_week == 6
}
