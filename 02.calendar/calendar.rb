#!/usr/bin/env ruby

require 'date'
require 'optparse'

# 引数受け取り
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
year = params['y'].to_i
month = params['m'].to_i

# 月と年を出力
normal_day = Date.new(year, month)
puts ("#{normal_day.month}月 #{normal_day.year}").center(20)
week = ['日','月','火','水','木','金','土']
puts week.join(' ')

# 初日左部分のスペースを出力
space = 3 * normal_day.wday
print ('').rjust(space)

# 月の最終日を取得
last_day = Date.new(year, month, -1)

# カレンダー出力
days = normal_day..last_day
days.each do |date|
  print ("#{date.day} ").rjust(3)
  print "\n" if date.saturday?
end

print "\n"
