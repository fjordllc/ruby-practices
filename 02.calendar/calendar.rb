#!/usr/bin/env ruby

require 'date'

if ARGV.empty?
  year = Date.today.year
  month = Date.today.month
else
  year = ARGV[1].to_i
  month = ARGV[3].to_i
end


date = Date.new(year, month)

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)


top = date.strftime("%-m月 %Y")
puts " "*6 + top

weekdays = %w[日 月 火 水 木 金 土]
weekdays.each do |weekday|
    print "#{weekday} "
end

puts "\n"

first_day_wday = first_day.wday
print "   "*first_day_wday

wday = first_day_wday
(1..last_day.day).each do |current_date|
  print current_date.to_s.rjust(2) + ' '
  wday += 1
  if wday % 7 == 0
    print  "\n"
  end
end


puts "\n" + "\n"

