#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'
require 'paint' # 'gem install paint'

today = Date.today
options = ARGV.getopts('', "y:#{today.year}", "m:#{today.mon}")

year = options['y'].to_i
month = options['m'].to_i

first_day = Date.new(year, month)
last_day = Date.new(year, month, -1)
dates = (first_day..last_day).to_a

full_month_name = first_day.strftime('%B')
puts "     #{full_month_name} #{year}"
puts ' Su Mo Tu We Th Fr Sa'
dates.each do |date|
  first_day_space = '   ' * date.cwday if date == first_day && date.cwday != 7
  early_month_space = date.day < 10 ? ' ' : ''
  date_display = date == today ? Paint[today.day, :inverse] : date.day
  new_line = date.saturday? ? "\n" : ''
  print ("#{first_day_space}#{early_month_space} #{date_display}#{new_line}")
end
