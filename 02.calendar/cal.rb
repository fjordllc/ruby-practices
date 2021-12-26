#!/usr/bin/env ruby
require 'date'
require 'optparse'

def calender
  today = Date.today
  options = ARGV.getopts('y:m:')
  option_year = options['y']
  option_month = options['m']
  year =  option_year == nil ? today.year : option_year.to_i
  month = option_month == nil ? today.month : option_month.to_i
  end_date = Date.new(year, month, -1).day
  dates = (1..end_date).map do |d|
    Date.new(year, month, d)
  end

  puts "#{month}月 #{year}".center(20)
  puts ['日', '月', '火', '水', '木', '金', '土'].join(' ')
  print '   ' * dates.first.wday
  dates.each do |d|
    if d.saturday?
      print d.day.to_s.rjust(2) + "\n"
    else
      print d.day.to_s.rjust(2) + ' '
    end
  end
  puts "\n"
end

calender
