require 'date'
require 'optparse'

options = ARGV.getopts('m:y:')
year = options["y"]
month = options["m"]

if year && month
  puts "　　　　#{month}月　#{year}"
  puts "日　月　火　水　木　金　土"
else
  today = Date.today.to_s.split("-")
  this_year = today[0]
  this_month = today[1]
  this_day = today[2]
  puts "　　　　#{this_month}月 #{this_year}"
  puts "日　月　火　水　木　金　土"
end