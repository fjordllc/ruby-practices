#!/usr/bin/env ruby
require 'date'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.on('-y YEAR', Integer) do |y|
    options[:year] = y
  end

  opts.on('-m MONTH', Integer) do |m|
    options[:month] = m
  end
end.parse!

year = options[:year] || Date.today.year
month = options[:month] || Date.today.month

def cal(year, month)
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)

  puts "   #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"

  print "   " * first_day.wday

  (first_day..last_day).each do |date|
    print date.day.to_s.rjust(2) + " "
    puts if date.saturday?
  end

  puts if last_day.wday != 6
end

cal(year, month)
