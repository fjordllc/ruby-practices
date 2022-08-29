#!/usr/bin/env ruby

require 'date'
require 'optparse'

w_list = ['日','月','火','水','木','金','土']

options = ARGV.getopts('y:', 'm:')
if options['y'] != nil and options['y'] =~ /^[0-9]+$/
  y = options['y'].to_i
else
  y = Date.today.year.to_i
end
if options['m'] != nil and options['m'] =~ /^[0-9]+$/
  m = options['m'].to_i
else
  m = Date.today.month.to_i
end

today_flg = false
today = Date.today
if today.year == y and today.month == m 
  today_flg = true
end

num_first_day_week = Date.new(y, m, 1).strftime('%u').to_i
last_day = Date.new(y, m, -1).day

puts ' '*5 + "#{y}年#{m}月"
w_list.each do |val|
  print val + ' '
end
puts

if num_first_day_week == 7
  week_count = 7
elsif
  week_count = 7 - num_first_day_week
  init = '   ' * num_first_day_week
end

print init
last_day.times do |i|
  if week_count == 0
    puts
    week_count = 7
  end
  print sprintf("%-3d", i+1)
  week_count -= 1
end
puts
