#!/usr/bin/env ruby
require 'date'
require 'optparse'

params = ARGV.getopts(' ', "y:#{Date.today.year}", "m:#{Date.today.month}")

# パラメータを整数に変換
year = (params["y"] || Date.today.year).to_i
month = (params["m"] || Date.today.month).to_i

# 指定された月のカレンダーを出力するメソッド
def print_calendar(year, month)
  start_date = Date.new(year, month, 1)
  end_date = Date.new(year, month, -1)
  puts "#{month}月 #{year}".center(20)
  puts '日 月 火 水 木 金 土'
  print '   ' * start_date.wday

  (start_date..end_date).each do |date|
    print date.day.to_s.rjust(2) + ' '
    print "\n" if date.saturday?
  end
  print "\n"
end

print_calendar(year, month)