require "date"
require "optparse"

day = Date.today
choice = ARGV.getopts("y:", "m:")

if choice["y"]
  year = choice["y"].to_i
else
  year = day.year
end

if choice["m"]
  month = choice["m"].to_i
else
  month = day.month
end

top = Date.new(year, month, 1).strftime("%B %Y")
firstday = Date.new(year, month, 1).wday
lastday = Date.new(year, month, -1).day
week = %w(日 月 火 水 木 金 土)

puts top.center(20)
puts week.join(" ")
print "   " * firstday

weekly = firstday
(1..lastday).each do |date|
  print date.to_s.rjust(2) + " "
  weekly = weekly + 1
  if weekly % 7 == 0
    print "\n"
  end
end
print "\n"