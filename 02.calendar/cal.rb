#!/usr/bin/env ruby

require 'date'
require 'optparse'

year = Date.today.year
month = Date.today.month

OptionParser.new do |opt|
  opt.on('-y YEAR', Integer) { |v| year = v }
  opt.on('-m MONTH', Integer) { |v| month = v }
  opt.parse!
end

# カレンダーの実装
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

first_wday = first_day.wday  # 0=日, 1=月, ... 6=土
days_in_month = last_day.day  # その月の日数

# ヘッダーを表示
puts "      #{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

# カレンダーを組み立てる
week = []
(0...first_wday).each { week << "   " }

(1..days_in_month).each do |day|
  week << sprintf("%2d", day)
  if week.size == 7
    puts week.join(" ")
    week = []
  end
end

puts week.join(" ") if week.size > 0
