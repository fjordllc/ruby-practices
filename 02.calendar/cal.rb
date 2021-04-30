require "date"
require 'optparse'

opt = OptionParser.new

opt.on("-y") {|year|}
opt.on("-m") {|month|}

p year = ARGV[1].to_i
p month = ARGV[3].to_i
# year = ARGV[0] ? ARGV[0].to_i : Date.today.year
# month = ARGV[1] ? ARGV[1].to_i : Date.today.month

WEEK_TABLE = [
  [99, 99, 99, 99, 99, 99,  1,  2,  3,  4,  5,  6,  7],
  [ 2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14],
  [ 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
  [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28],
  [23, 24, 25, 26, 27, 28, 29, 30, 31, 99, 99, 99, 99],
  [30, 31, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99],
]

today = Date.today
# year = Date.today.year
# month = Date.today.mon
first_wday = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1).day
start = 6 - first_wday

puts today.strftime("%B %Y").center(21)
print "  日 月 火 水 木 金 土 "
puts ""
WEEK_TABLE.each do |week|
  buf = ""
  week[start, 7].each do |day|
    if day > last_day
      buf << "   "
    else
      buf << sprintf("%3d", day)
    end
  end
  puts buf
end
