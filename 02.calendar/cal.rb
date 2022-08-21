#!/usr/bin/env ruby

require 'date'
require 'optparse'

# list for day of week
wList = ['日','月','火','水','木','金','土']

options = ARGV.getopts('y:', 'm:')
# year
if options['y'] != nil and options['y'] =~ /^[0-9]+$/
    y = options['y'].to_i
else
    y = Date.today.year.to_i
end
# month
if options['m'] != nil and options['y'] =~ /^[0-9]+$/
    m = options['m'].to_i
else
    m = Date.today.month.to_i
end
# day of week
# w = nil

# Check calender contains today
todayFlg = false
today = Date.today
if today.year == y and today.month == m
    todayFlg = true
end

# Get number of First day of week
numFirstDayWeek = Date.new(y, m, 1).strftime('%u').to_i
# Get List day of specified month
lastDay = Date.new(y, m, -1).day

# Output HEADER to Console
puts ' '*5 + y.to_s + '年' + m.to_s + '月'
wList.each do |val|
    print val + ' '
end
puts
# Date Initial Setting
if numFirstDayWeek == 7
    cont = 7
elsif
    cont = 7-numFirstDayWeek.to_i
    init = '   '*numFirstDayWeek
end
# Output DATE to Console
print init
lastDay.times do |i|
    if cont == 0
        puts
        cont = 7
    end
    if i+1 < 10
        print (i+1).to_s + '  '
    else
        print (i+1).to_s + ' '
    end

    cont -= 1
end
puts
