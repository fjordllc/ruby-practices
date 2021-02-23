require 'date'
require 'optparse'

today   = Date.today
params  = ARGV.getopts("", "y:#{today.year}", "m:#{today.month}")

year  = params["y"].to_i 
month = params["m"].to_i
  
first_day_number = Date.new( year, month, 1 ).cwday
last_day_number  = Date.new( year, month, -1 ).strftime('%d').to_i

puts "#{month}月#{year}".center(20)
puts "日 月 火 水 木 金 土"

blank = "   " * first_day_number
print blank if first_day_number != 7
 
(1..(last_day_number)).each do |i|
  print i.to_s.rjust(2) + " "
  first_day_number = first_day_number + 1
  print "\n" if first_day_number % 7 == 0
end

print "\n"
