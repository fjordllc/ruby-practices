#!/usr/bin/ruby

require 'optparse'
require 'date'

def show(year, month)
  lastday = Date.new(year, month, -1)
  number_of_days = lastday.day
  
  puts "#{month}月 #{year}"
  puts "日 月 火 水 木 金 土"  

  firstday = Date.new(year, month, 1)
  s = "   " * firstday.wday
  print(s)

  (1..number_of_days).each do |x|
    if x < 10
      print " "
    end

    print "#{x} "

#    if x % 7 == ((7 - firstday.wday) % 7)
    if (x + firstday.wday) % 7 == 0
      puts 
    end

  end 
  puts

end

today = Date.today
year = today.year
month = today.month

options = ARGV.getopts('y:','m:')
if options['y']
  year = options['y'].to_i
end
if options['m']
  month = options['m'].to_i
end



show(year, month)


=begin
date = Date.new(year, month, -1)
puts date.day
#show_from_sunday(year, month, date.day)
#show_from_monday(year, month)
firstday = Date.new(year, month, 1)
if firstday.sunday?
  show_from_sunday(year, month)
end
if firstday.monday?
  show_from_monday(year, month, date.day)
end

=end
