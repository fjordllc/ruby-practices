#!/usr/bin/env ruby

require 'optparse'
opt = OptionParser.new
opt.on('-m [val]') {|m| }
opt.on('-y [val]') {|y| }

opt.parse!(ARGV)


# puts sprintf("      %d月 %d", month,year)
# print sprintf("%s " * weekdays.length, *weekdays)
# disp_days.each_with_index {|day,i|
#   if month == Date.today.month && day == Date.today.day
#     print "\e[31m"
#   else
#     print "\e[0m"
#   end
#   print sprintf("%2s ",day)
#   if i % 7 == 0
#     puts ""
#   end
#   print "\e[0m"
# }
# puts ""
