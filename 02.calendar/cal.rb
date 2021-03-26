
#!/usr/bin/env ruby
  
require "date"

head = Date.today.strftime("%m月  %Y")
year = Date.today.year
month = Date.today.month
week = %w(日 月 火 水 木 金 土)
firstday = Date.new(year,month,1).wday
lastday = Date.new(year,month,-1).day

puts head.center(20)
puts week.join(" ")
print " " * firstday

day = firstday
(1..lastday).each do |x|
  print x.to_s.rjust(2) + " "
  day = 1 + day
  if day%7 == 0
    print "\n"
  end
end
if day %7 != 0
  print "\n"
end
