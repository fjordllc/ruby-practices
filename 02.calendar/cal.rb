#!/usr/bin/env ruby
  
require "date"
require "optparse"

params = ARGV.getopts("","y:#{Date.today.year}","m:#{Date.today.month}","d:#{Date.today.day}")


year = params.values[0].to_i
month = params.values[1].to_i
day = params.values[2].to_i

first_day = Date.new(year,month,1)
first_date = first_day.day
last_day = Date.new(year,month,-1)
last_date = last_day.day
firstday_wday = first_day.wday

hash = {}
while first_date <= last_date
  hash[:"#{first_date}"] = first_day.wday
  first_date += 1
  first_day += 1
end

puts ("#{month}"+ "月" + " " +  "#{year}").center(20)
puts ["日","月","火","水","木","金","土"].join(" ")

print "  " * firstday_wday + " "

hash.each do |day, wday|
  if wday %7 == 0
    print "\n"
  end
  if day.length == 1
    print " " + day.to_s + " "
  elsif
    print day.to_s + " "
  end
end
if last_date != 0
  print "\n"
end
