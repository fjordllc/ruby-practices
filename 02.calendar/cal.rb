require 'optparse'
require 'Date'

# get argv
options = ARGV.getopts('y:', 'm:')
options["y"] = Date.today.year  if options["y"].nil?
options["m"] = Date.today.month if options["m"].nil?

cal_year  = options["y"].to_i
cal_month = options["m"].to_i

# set calendaer
first_wday = Date.new(cal_year, cal_month, 1).wday
last_day = Date.new(cal_year, cal_month, -1).day

# display calender
puts "      #{cal_month}月 #{cal_year}"
puts "日 月 花 水 木 金 土"

next_sat = 7 - first_wday

first_wday.times do |i|
  print "   "
end

def put_date(d)
  if d < 10
    return " #{d} "
  else
    return "#{d} "
  end
end

(1..last_day).each do |d|
  if d == next_sat
    next_sat += 7
    puts put_date(d)
  else
    print put_date(d)
  end
end
