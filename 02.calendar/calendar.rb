#!/usr/bin/env ruby
require 'optparse'
require 'date'

options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
y_of_today = options['y'].to_i
m_of_today = options['m'].to_i

puts ("#{m_of_today}月"+ " " + "#{y_of_today}").center(20)

first_day = Date.new(y_of_today, m_of_today, 1)
last_day = Date.new(y_of_today, m_of_today, -1)

day_of_week = %w[日 月 火 水 木 金 土]
day_of_week.each do |d|
  print d
  print ' '
end
puts "\n"

print "\s" * 3 if first_day.monday?
print "\s" * 6 if first_day.tuesday?
print "\s" * 9 if first_day.wednesday?
print "\s" * 12 if first_day.thursday?
print "\s" * 15 if first_day.friday?
print "\s" * 18 if first_day.saturday?

(first_day..last_day).each do |everyday|
  print everyday.strftime('%e')
  print ' '
  if everyday.saturday?
    print "\n"
  end
end
puts "\n"

