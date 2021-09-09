#!/usr/ruby/ruby-practices/02.calendar/env ruby

require 'date'
require 'optparse'
require 'paint'

year = Date.today.year
month = Date.today.month

opt = OptionParser.new
opt.on('-y [year]', Integer) { |val| year = val if val != nil }
opt.on('-m [month]', Integer) { |val| month = val if val != nil}
opt.parse(ARGV)

days_of_month = Date.new(year, month, -1).day
days_number = Date.new(year, month, 1).day
day_of_week = Date.new(year, month, 1).cwday

print "      " + "#{month}月 #{year}" + "\n日 月 火 水 木 金 土\n"
day_of_week.times {print "   " if day_of_week != 7}

days_of_month.times do |i|
  date = Date.new(year, month, i + 1)
  i + 1 < 10 ? space = " " : space = ""
  if Date.today == date
    print Paint["#{space}#{date.day}", :inverse] + " "
  else
    print "#{space}#{date.day}" + " "
  end
  print "\n" if date.cwday == 6
end

puts "\n\n"
