require 'optparse'
require 'date'

params = ARGV.getopts("y:", "m:")

year = params["y"]&.to_i || Date.today.year
month = params["m"]&.to_i || Date.today.mon

START_DAY = 1
END_DAY = Date.new(year, month, -1).day

day_of_week_list = ["日", "月", "火", "水", "木", "金", "土"]

print "      #{month}月 #{year}      \n"

print "#{day_of_week_list.join(' ')}\n"

def is_saturday?(year, month, day)
  Date.new(year, month, day).wday == 6
end

def is_today?(year, month, day)
  Date.today == Date.new(year, month, day)
end

print "   " * Date.new(year, month, START_DAY).wday

(START_DAY..END_DAY).each do |day|
  display_day = is_today?(year, month, day) ? "\e[30;43m#{day.to_s}\e[0m" : day.to_s
  display_string = display_day.rjust(2)
  suffix = is_saturday?(year, month, day) ? "\n" : " "
  print "#{display_string}#{suffix}"
end

print "\n"