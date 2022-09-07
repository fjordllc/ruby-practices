#!/usr/bin/env ruby
require "date"
require 'optparse'
opt = OptionParser.new


# コマンドライン引数処理
options = ARGV.getopts('y:m:')
year = options["y"].to_i
month = options["m"].to_i

if year == 0
  year = Date.today.year
end
if month == 0
  month = Date.today.month
end


month_end_date = Date.new(year, month, -1)
month_end_day = month_end_date.day
    
day = 1
saturday = 6
week = ["  ","  ","  ","  ","  ","  ","  "]

print "     #{month}月 #{year}    \n"
print "日 月 火 水 木 金 土\n"
    
while day <= month_end_day do
  day_date = Date.new(year, month, day)
  one_day =day_date.day
  one_day_of_week = day_date.wday #今日の日付の曜日
    
  one_day_shaped = sprintf("%2s", one_day)
  week[one_day_of_week] = one_day_shaped
  
  if one_day_of_week == saturday
    puts week.join(" ")
    week = ["  ","  ","  ","  ","  ","  ","  "]
  end
    
  if day == month_end_day
    puts week.join(" ")
  end 
    day = day + 1
end
