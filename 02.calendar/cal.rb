# frozen_string_literal: true

require 'date'
require 'optparse'

options = OptionParser.new do |opts|
  opts.banner = 'Usage: ruby cal.rb [options]'
  opts.on('-m', 'Inspect month')
  opts.on('-y', 'Inspect year')
end

begin
  # Parse commandline
  options.parse(ARGV)
  # Hash. ex. {"m"=>"5", "y"=>"2021"}
  year_month = ARGV.getopts('m:', 'y:')
rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
  puts e.message
  puts options.help
  exit
end

# This year and this month if option is not defined
year = year_month['y'] || Date.today.year
month = year_month['m'] || Date.today.month

# Validation of year
if year.to_i.integer? && year.to_i.between?(1, 9999)
  year = year.to_i
else
  puts "-y `#{year}` not in range 1..9999"
  exit
end

# Validation of month
if month.to_i.integer? && month.to_i.between?(1, 12)
  month = month.to_i
else
  puts "-m  `#{month}` not in range 1..12"
  exit
end

# Get last day of year month
last_day = Date.new(year, month, -1).day

# key: day, value: week number like below.
# 0: Sun, 1: Mon, .... 6: Sat
day_week = {}
(1..last_day).each do |day|
  week = Date.new(year, month, day).wday
  day_week[day] = week
end

# Output Calendar: header
week_str = 'Su Mo Tu We Th Fr Sa'
puts "#{month}月 #{year}".center(week_str.length)
puts week_str

# Output Calendar: body
day_week.each do |k, v|
  # Indent of first week
  print ' ' * 3 * v if k == 1

  # Newline if the end is Sat
  if v % 7 == 6
    printf("%2d \n", k)
  else
    printf('%2d ', k)
  end
end
