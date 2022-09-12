!/usr/bin/env ruby

require 'optparse'
require 'date'

options = ARGV.getopts('m:', 'y:')
month = options['m'] || Date.today.mon
year = options['y'] || Date.today.year
puts "#{month}月 #{year}".center(20)

day_of_week = %w(日 月 火 水 木 金 土)
print " "+day_of_week.join(" ") + "\n"

first_day = Date.new(year.to_i, month.to_i, 1)
last_day = Date.new(year.to_i, month.to_i, -1)

print "   " * first_day.wday

days_of_the_month = (first_day..last_day)

(days_of_the_month).each do |day|
  date_display = day.day.to_s.rjust(2)
  if day == Date.today
    print " " + "\e[30;47m#{date_display}\e[0m"
  else
    print " " + date_display
  end
  print "\n" if day.saturday?
end
