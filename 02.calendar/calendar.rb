require "date"
require "optparse"


today = Date.today
options = ARGV.getopts("y:", "m:")
year  = (options["y"] || today.year).to_i
month = (options["m"] || today.month).to_i
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
first_wday = first_day.wday
days = (first_day..last_day)
calender_head = first_day.strftime("%-m月 %Y")
day_of_the_week = "日 月 火 水 木 金 土"

puts calender_head.center(20)
puts day_of_the_week
print "  " + "   " * (first_wday -1)

days.each do |date|
    if date.sunday?
        print date.day.to_s.rjust(2)
    elsif date.saturday?
        print " " + date.day.to_s.rjust(2) + "\n"
    else
        print " " + date.day.to_s.rjust(2)
    end
end