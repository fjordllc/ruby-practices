#!/usr/bin/env ruby
# frozen_string_literal: true
require 'optparse'
require 'date'

options = ARGV.getopts('', "y:#{Date.today.year}", "m:#{Date.today.month}")
y_of_today = options['y'].to_i
m_of_today = options['m'].to_i

puts ("#{m_of_today}月 #{y_of_today}").center(20)

day_of_week = %w[日 月 火 水 木 金 土]
puts day_of_week.join(' ')

first_day = Date.new(y_of_today, m_of_today, 1)
last_day = Date.new(y_of_today, m_of_today, -1)

print ' ' * 3 * first_day.wday

(first_day..last_day).each do |day|
  print day.strftime('%e')
  print ' '
  print "\n" if day.saturday?
end
puts "\n"
