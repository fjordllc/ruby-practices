#!/usr/bin/env ruby

require 'date'
require 'optparse'

# 引数受け取り
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
year = params['y'].to_i
month = params['m'].to_i

# 月と年を出力
date_obj = Date.new(year, month)
puts ("#{date_obj.month}月 #{date_obj.year}").center(20)
week = ['日','月','火','水','木','金','土']
puts week.join(' ')

# 初日左部分のスペースを出力
space = 3 * date_obj.wday
print ('').rjust(space)

# 月の最終日を取得
last_day = Date.new(year, month, -1)

# カレンダー出力
days = date_obj..last_day
days.each do |date|
  print ("#{date.day} ").rjust(3)
  print "\n" if date.saturday?
end

print "\n"
