#!/usr/bin/env ruby

require 'date'
require 'optparse'

def output_calendar(year: Date.today.year, month: Date.today.month)

  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)

  puts first_day.strftime("%B %Y").center(20)
  puts %w(Su Mo Tu We Th Fr Sa).join(' ')

  first_wday = first_day.wday

  last_day_date = last_day.day

  days = (1..last_day_date).map { |n| n.to_s.rjust(2) }
  days = Array.new(first_wday, '  ').push(days).flatten.each_slice(7)

  days.each { |week| puts week.join(' ') }

end

def parsed_option

  options = {}

  opt = OptionParser.new

  opt.on('-y YEAR') { |v| options[:year] = v.to_i }
  opt.on('-m MONTH') { |v| options[:month] = v.to_i }

  opt.parse!

  options

end

output_calendar(**parsed_option)