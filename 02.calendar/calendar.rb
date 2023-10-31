#!/usr/bin/env ruby

require 'date'
require 'optparse'

params = ARGV.getopts('y:', 'm:')

if params['y']
  year = params['y'].to_i
else
  year = Date.today.year
end

if params['m']
  month = params['m'].to_i
else
  month = Date.today.month
end


day = Date.new(year, month)

puts day.strftime("%m月 %Y").center(20)
puts "日 月 火 水 木 金 土"
last_day = Date.new(day.year, day.month, -1).day
first_day_wday = Date.new(day.year, day.month, 1).wday
print "   " * first_day_wday
(1..last_day).each do |day|
  # 横並びに表示したいためputsではなくprintで出力する
  if day <= 9
    print " " + "#{day}" + " "
  else
    print "#{day}" + " "
  end

  if (first_day_wday + day) % 7 == 0
    print "\n"
  end
end
