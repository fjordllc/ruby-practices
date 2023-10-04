#! /usr/bin/env ruby

require "date"
require 'optparse'

opt = OptionParser.new

opt_year = nil
opt_month = nil

# 年と月を取得
opt.on('-y int') { |val| opt_year = val.to_i }
opt.on('-m int') { |val| opt_month = val.to_i }
opt.parse!(ARGV)

# 引数を指定しない場合は、今年・今月のカレンダーを表示させる
opt_year = Date.today.year if opt_year.nil?
opt_month = Date.today.month if opt_month.nil?

# カレンダーの「dd月 yyyy年」部分を表示
puts("      #{opt_month}月 #{opt_year}")

# 曜日を表示
days = %w[日 月 火 水 木 金 土]
puts(days.join(' '))

# 対象月の１日目の曜日を取得し、前にスペースを出力
first_day = Date.new(opt_year, opt_month, 1)
first_date_of_day = first_day.wday
(1..first_date_of_day).each do
  print(' ' * 3)
end

last_day = Date.new(opt_year, opt_month, -1)
# 日にちを出力
(first_day..last_day).each do |date|
  target = Date.new(opt_year, opt_month, date.day)

  # 今日の日付の部分の色を反転させる
  if target == Date.today
    print("\e[7m")
  else
    print("\e[0m")
  end

  # 日曜か土曜だった場合は、出力方法を変える
  if target.sunday?
    print(date.day.to_s.center(3))
  elsif target.saturday?
    puts(date.day.to_s.center(3))
  else
    print(date.day.to_s.center(3))
  end
end

puts
