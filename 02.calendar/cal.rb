#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new
month = nil
year = nil
now = Date.today

# コマンドラインに入力されたオプション(月と年)の値を取得
opt.on('-m int') { |v| month = v.to_i }
opt.on('-y int') { |v| year = v.to_i }
opt.parse!(ARGV)
month ||= now.month
year ||= now.year

# 入力された月の値が1から12に収まらない場合、処理を終了する
unless (1..12).cover?(month)
  puts '正しい月を入力してください'
  exit
end

# カレンダーに表示する月の初日、最終日を取得
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

# カレンダーの月と年の部分を表示する
puts("   #{first_day.strftime('%B')} #{year}")
# カレンダーの曜日の部分を表示する
puts('Su Mo Tu We Th Fr Sa')
# 表示するカレンダーの初日が月曜日から離れている場合、一日ごとに3文字分の空白を出力する
print ' ' * (first_day.wday * 3)

# カレンダーの日付の部分を表示する
(first_day..last_day).each do |date|
  day_to_display = date.day.to_s.rjust(2, ' ')
  # 今日の日付を表示する場合のみ、色を反転して表示する
  print date == Date.today ? "\e[30m\e[47m#{day_to_display}\e[0m " : "#{day_to_display} "
  # 表示した日付が土曜日(カレンダーの右端)の場合、表示を改行する
  puts if date.saturday?
end
puts
