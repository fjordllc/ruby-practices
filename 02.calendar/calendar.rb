#!/usr/bin/env ruby

require 'date'
require 'optparse'

todays = Date.today
this_year = todays.year
this_month = todays.month

opt = OptionParser.new
opt.on('-m [manth]', '月を指定します-m') { |m| this_month = m.to_i }
opt.on('-y [year]', '年を指定します -y') { |y| this_year = y.to_i }
opt.parse!(ARGV)

first_day = Date.new(this_year, this_month, 1)
last_day = Date.new(this_year, this_month, -1)

puts "      #{this_month}月 #{this_year}"
puts '日 月 火 水 木 金 土'

first_day.wday.times do
  print '   '
end

(first_day..last_day).each do |date|
  print(sprintf("%2d", date.day.to_s) + ' ')
  if date.saturday?
    print("\n")
  end
end
