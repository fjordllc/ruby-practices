#!/usr/bin/env ruby
require 'optparse'
require 'date'

params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

year = params.values[0].to_i
month = params.values[1].to_i

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

puts "       #{month}月 #{year}"
puts '日 月 火 水 木 金 土'

print "   " * first_date.wday

(first_date..last_date).each do |date|
  print date.strftime('%e ')
  puts if date.saturday?
end