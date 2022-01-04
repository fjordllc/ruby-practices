#!/usr/bin/env ruby
require 'date'
require 'optparse'

today = Date.today
options = ARGV.getopts('y:m:')
year =  options['y']&.to_i || today.year
month = options['m']&.to_i || today.month
end_date = Date.new(year, month, -1).day
dates = (1..end_date).map do |d|
  Date.new(year, month, d)
end

puts "#{month}月 #{year}".center(20)
puts ['日', '月', '火', '水', '木', '金', '土'].join(' ')
print '   ' * dates.first.wday
dates.each do |d|
  print "#{d.day.to_s.rjust(2)} "
  print "\n" if d.saturday?
end
