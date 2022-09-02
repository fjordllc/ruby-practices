#!/usr/bin/env ruby

require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-m')
opt.on('-y')

opt.parse!(ARGV)
month = ARGV[0] || Date.today.mon
year = ARGV[1] || Date.today.year

header = "#{month}月"+" "+year.to_s
print header.center(20) + "\n"

day_of_week = %w(日 月 火 水 木 金 土)
  print " "+day_of_week.join(" ") + "\n"

First_day = Date.new(year.to_i, month.to_i, 1)
last_day = Date.new(year.to_i, month.to_i, -1)

space = First_day.wday
space.times do
print "   "
end

days_of_the_month = (First_day..last_day)

(days_of_the_month).each do |day|
  number = day.wday
  date_display = day.day.to_s.rjust(2)
  case
  when day == Date.today && number == 6
    print " " + "\e[30;47m#{date_display}\e[0m" + "\n"
  when day == Date.today
    print " " + "\e[30;47m#{date_display}\e[0m"
  when number == 6
    print " " + date_display + "\n"
  else
    print " " + date_display
  end
end
