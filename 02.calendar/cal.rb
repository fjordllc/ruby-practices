#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

params = ARGV.getopts('', 'y:', 'm:')

today = Date.today

def print_calendar(year, month)
  start_date = Date.new(year, month, 1)
  end_date = Date.new(year, month, -1)
  puts "#{month}月 #{year}".center(20)
  puts '日 月 火 水 木 金 土'
  print '   ' * start_date.wday

  (start_date..end_date).each do |date|
    print "#{date.day.to_s.rjust(2)} "
    print "\n" if date.saturday?
  end
  print "\n"
end

year = params['y'] ? params['y'].to_i : today.year
month = params['m'] ? params['m'].to_i : today.month

print_calendar(year, month)
