#!/usr/bin/env ruby

require 'date'
require 'optparse'

def calendar(year = Date.year, month = Date.month)
  start_date = Date.new(year, month, 1)
  end_date = Date.new(year, month, -1)
  day_array = Array.new(start_date.wday, nil).concat((start_date.day..end_date.day).to_a)

  puts "#{start_date.strftime('%B %Y')}".center(20)
  puts "Su Mo Tu We Th Fr Sa"
  day_array.each_slice(7) do |slice|
    formatted_slice = slice.map { |d| d.to_s.rjust(2) }
    puts formatted_slice.join(" ")
  end
end

options = { year: Date.today.year, month: Date.today.month}
OptionParser.new do |opts|
  opts.on('-y VAL', Integer) { |v| options[:year] = v }
  opts.on('-m VAL', Integer) { |v| options[:month] = v }
end.parse!

calendar(options[:year], options[:month])
