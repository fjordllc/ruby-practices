#!/usr/bin/env ruby

require 'date'

# TODO 引数を受け取ってyear,monthに入れる
# year = 
# month = 

#月と年を出力
date = Date.today
puts ("#{date.month}月 #{date.year}").center(20)

week = ['日','月','火','水','木','金','土']

puts week.join(' ')

first_day = Date.new(2021, 6, 1).day
last_day = Date.new(2021, 6, -1).day

days = first_day..last_day
days.each do |day|
    i = Date.new(2021, 6, day).day
    wdays = Date.new(2021, 6, day).wday
	is_saturday = Date.new(2021, 6, day).saturday?

    # 最初の日が日曜でなかったら、スペースを出力する
    if day == 1
        if wdays == 0
            print ""
        elsif wdays == 1
            print "   "
        elsif wdays == 2
            print "      "
        elsif wdays == 3
            print "         "
        elsif wdays == 4
            print "            "
        elsif wdays == 5
            print "               "
        elsif wdays == 6
            print "                  "
        end
    end
    print ("#{i} ").rjust(3)
    if is_saturday 
        print "\n"
    end
end

print "\n"
