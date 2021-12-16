#!/usr/bin/env ruby

require 'date'
require 'optparse'

options = ARGV.getopts('y:m:')
option_year = options['y'] 
option_month = options['m']
this_year = Date.today.year
this_month = Date.today.month

case
when option_year == nil && option_month == nil
  year = this_year
  month = this_month
when option_year != nil && option_month != nil
  year = option_year.to_i
  month = option_month.to_i
when option_month != nil
  year = this_year
  month = option_month.to_i
when option_year != nil
  return
end

end_date = Date.new(year, month, -1).day
date_array = (1..end_date).map do |d|
  Date.new(year, month, d)
end

def create_header(year, month)
  header = month.to_s + '月 ' + year.to_s
  day_of_the_week = ['日', '月', '火', '水', '木', '金', '土'].join(' ')
  puts header.center(20)
  puts day_of_the_week
end

def create_calender(date_array)
  blank_space = '   ' * date_array.first.wday
  calender_array = date_array.map do |d|
    if d.saturday? == true
      d.day.to_s.rjust(2) + "\n"
    else
      d.day.to_s.rjust(2) + " "
    end
  end
  calender = calender_array.unshift(blank_space)
  calender.each do |a|
    print a
  end
end

create_header(year, month)
create_calender(date_array)

