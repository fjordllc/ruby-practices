require "date"
require 'optparse'

options = ARGV.getopts("m:", "y:")
month = Date.today.month
year = Date.today.year

if options["y"] != nil
  year = options["y"].to_i
end
if options["m"] != nil 
  month = options["m"].to_i
end

WEEK_TABLE = [
  [99, 99, 99, 99, 99, 99,  1,  2,  3,  4,  5,  6,  7],
  [ 2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14],
  [ 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
  [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28],
  [23, 24, 25, 26, 27, 28, 29, 30, 31, 99, 99, 99, 99],
  [30, 31, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99],
]

first_wday = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1).day
start = 6 - first_wday
year_month = "#{year}年 #{month}月"

puts year_month.center(21)
print "  日 月 火 水 木 金 土 "
puts ""
WEEK_TABLE.each do |week|
  buf = ""
  week[start, 7].each do |day|
    day > last_day ? buf << "   " : buf << sprintf("%3d", day)
  end
  puts buf
end
