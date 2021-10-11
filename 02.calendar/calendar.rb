#!/usr/bin/env ruby

require 'date'
require 'optparse'

#引数受け取り
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
year = params['y'].to_i
month = params['m'].to_i

#月の初日と最終日を取得
first_day = Date.new(year, month, 1).day
last_day = Date.new(year, month, -1).day

#月と年を出力
date = Date.new(year, month)
puts ("#{month}月 #{date.year}").center(20)
week = ['日','月','火','水','木','金','土']
puts week.join(' ')

#カレンダー出力
days = first_day..last_day
days.each do |day|
    i = Date.new(year, month, day).day
    wdays = Date.new(year, month, day).wday
	is_saturday = Date.new(year, month, day).saturday?

    # 初日左部分のスペース埋め処理
    if day == 1
        space = 3 * wdays
        print ('').rjust(space)
    end
    print ("#{i} ").rjust(3)
    if is_saturday 
        print "\n"
    end
end

print "\n"
