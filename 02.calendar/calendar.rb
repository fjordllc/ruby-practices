#!/usr/bin/env ruby

require 'date'
require 'optparse'

today = Date.today
year = today.year
month = today.month

opt = OptionParser.new
opt.on('-m [month]', '月を指定します -m') { |m| month = m.to_i }
opt.on('-y [year]', '年を指定します -y') { |y| year = y.to_i }
opt.parse!(ARGV)

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

puts "      #{month}月 #{year}"
puts '日 月 火 水 木 金 土'

first_date.wday.times do
  print '   '
end

(first_date..last_date).each do |date|
  print "#{date.day.to_s.rjust(2)} "
  if date.saturday?
    print("\n")
  end
end
