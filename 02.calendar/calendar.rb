#!/usr/bin/director/env ruby

require 'date'
require 'optparse'
require 'paint'

today = Date.today.day

opt = OptionParser.new
opt.on('-y')
opt.on('-m')
opt.parse(ARGV)

if  ARGV[0] == "-y"
  year = ARGV[1].to_i
else
  year = Date.today.year
end

if ARGV[0] == "-m"
  month = ARGV[1].to_i
elsif ARGV[2] == "-m"
  month = ARGV[3].to_i
else
  month = Date.today.month
end

days_of_month = Date.new(year, month, -1).day
days_number = Date.new(year, month, 1).day
day_of_week = Date.new(year, month, 1).cwday
firstday_switch = true

print "      #{month}月 #{year}
日 月 火 水 木 金 土\n"

days_of_month.times do
  if firstday_switch == true && day_of_week != 7
    day_of_week.times do
      print "   "
    end
    firstday_switch = false
  end
  if days_number < 10
    space = " "
  else
    space = ""
  end
    if Date.today.day == Date.new(year, month, days_number).day
      print Paint["#{space}#{Date.new(year, month, days_number).day}", :inverse]
    else
      print "#{space}#{Date.new(year, month, days_number).day}"
    end
  print " "
  if Date.new(year, month, days_number).cwday == 6
    print "\n"
  end
  days_number += 1
end
puts "\n\n"
