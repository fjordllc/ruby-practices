require "date"
require "optparse"

options = ARGV.getopts("y:m:")

if options["y"].nil?
  year = Date.today.year
else
  year = options["y"].to_i
end

if options["m"].nil?
  month = Date.today.month
else
  month = options["m"].to_i
end

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
first_wday = first_day.wday
days = (first_day..last_day)
week = ["日", "月", "火", "水", "木", "金", "土"]

puts "#{month}月 #{year}".center(20)
puts week.join(" ")
print "   " * first_wday
days.each do |day|
  print day.day.to_s.rjust(2)
  print " "
  if day.saturday?
    print "\n"
  end
end
