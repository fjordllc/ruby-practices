#!/usr/bin/env ruby

require 'date'
require 'optparse'

today = Date.today
# ターゲットの日付は、todayで初期化する
target_year = today.year
target_month = today.month

opt = OptionParser.new
# -yオプションで入力された年
opt.on('-y VAL', String) do |y|
  # ターゲット年を上書き
  target_year = y.to_i
  raise OptionParser::InvalidArgument.new("年は1970~2100の間で設定してください") if target_year < 1970 || 2100 < target_year
end

#-mオプションで入力された月
opt.on('-m VAL') do |m|
  # ターゲット月を上書き
  target_month = m.to_i
  raise OptionParser::InvalidArgument.new("月は1~12の間で設定してください") if target_month < 1 || 12 < target_month
end

# parseしないとopt.onのブロックが実行されないので注意
opt.parse!(ARGV)

first_date = Date.new(target_year, target_month, 1)
last_date = Date.new(target_year, target_month, -1)
days_in_month = []
1.upto(last_date.day) {|day| days_in_month.push(day)}
# 月初めが月曜日でない場合はその数だけ空文字を入れてフォーマットを調整する
(first_date.cwday).times {
  days_in_month.unshift('')
}

RED = 31
BLUE = 34

# 基本、数字のカラーは赤色で出力する
puts "等しい" if "#{target_year}-#{target_month}-19" == today.to_s
printf("%33s", "\e[#{RED}m#{target_year}\e[0m年 \e[#{RED}m#{target_month}\e[0m月")
puts
printf("%14s", "日 月 火 水 木 金 土")
days_in_month.length.times do |i|
  color = RED
  puts if i % 7 == 0
  # 日付がtodayと同じ時だけ、カラーを青色にする
  color = BLUE if target_month < 10 && "#{target_year}-0#{target_month}-#{i}".eql?(today.to_s)
  color = BLUE if target_month > 10 && "#{target_year}-#{target_month}-#{i}".eql?(today.to_s)
  printf("%8s", "\e[#{color}m#{days_in_month[i]}")
end
puts
