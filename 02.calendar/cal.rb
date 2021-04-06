#!/usr/bin/env ruby

require "date"
require "optparse"

params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

year = params.values[0].to_i
month = params.values[1].to_i

first_date = Date.new(year,month,1)
last_date = Date.new(year,month,-1)
last_day = last_date.day
firstday_wday = first_date.wday

hash = {}
1.upto(last_day) do |n|
	hash[n] = (first_date + n - 1).wday
end

puts ("#{month}月 #{year}").center(20)
puts "日 月 火 水 木 金 土"
print "   " * firstday_wday

hash.each do |day, wday|
	if wday == 0 && day != 1
		print "\n"
	end
	print day.to_s.rjust(2) + " "
end
if last_date != 0
	print "\n"
end
