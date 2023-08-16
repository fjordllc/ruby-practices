#!/usr/bin/env ruby

require 'date'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.on('-y year', Integer) do |year|
    options[:year] = year
  end
  opts.on('-m month', Integer) do |month|
    options[:month] = month
  end
end.parse!

year = options[:year] || Date.today.year
month = options[:month] || Date.today.month

date = Date.new(year, month)

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

top = date.strftime("%-m月 %Y")
puts " " * 6 + top

weekdays = %w[日 月 火 水 木 金 土]
result = weekdays.join(' ')
print result

puts 

first_day_wday = first_day.wday
print "   " * first_day_wday

wday = first_day_wday
(1..last_day.day).each do |current_date|
  print current_date.to_s.rjust(2) + ' '
  wday += 1
  if wday % 7 == 0
    puts
  end
end

puts "\n\n"

