#!/usr/bin/env ruby

require 'date'
require 'optparse'

# 引数受け取り
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
year = params['y'].to_i
month = params['m'].to_i

# 月と年を出力
date = Date.new(year, month)
puts ("#{date.month}月 #{date.year}").center(20)
week = ['日','月','火','水','木','金','土']
puts week.join(' ')

# 初日左部分のスペースを出力
space = 3 * date.wday
print ('').rjust(space)

# 月の最終日を取得
last_day = Date.new(year, month, -1)

# カレンダー出力
days = date.day..last_day.day
days.each do
  print ("#{date.day} ").rjust(3)

  if date.saturday?
    print "\n"
  end

  date += 1

end

print "\n"
