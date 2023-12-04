#!/usr/bin/env ruby
require 'optparse'
require "date"
opt = OptionParser.new
month = ""
year = ""
now = Date.today
# コマンドラインに入力されたオプション(月と年)の値を取得
opt.on('-m int') {|v| month = v }
opt.on('-y int') {|v| year = v }
opt.parse!(ARGV)
month = now.month if month.empty?
year = now.year if year.empty?
month = month.to_i
year = year.to_i
# 月の値に13以上、または1未満が入力されていた場合、処理を終了する
if month > 12 || month < 1
  puts "正しい月を入力してください"
  exit
end
# 実行時の日付と、カレンダーに表示する月の最終日を取得
last_day = Date.new(year,month,-1).day
# カレンダーの月と年の部分を表示する
puts("   #{Date::MONTHNAMES[month]} #{year}")
# カレンダーの曜日の部分を表示する
puts("Su Mo Tu We Th Fr Sa")
# 表示するカレンダーの初日が、月曜日から離れている分だけ、一日ごとに3文字分の空白を出力する
print " " * (Date.new(year, month, 1).wday * 3) 
# カレンダーの日付の部分を表示する
(1..last_day).each do |day|
  # 今日の日付を表示する場合、色を反転して表示する
  if day == now.day && month == now.month && year == now.year
    print "\e[30m\e[47m#{day.to_s.rjust(2," ")}\e[0m "
  else
    print "#{day.to_s.rjust(2," ")} "
  end
  # 表示した日付が土曜日(カレンダーの右端)の場合、表示を改行する
  puts if Date.new(year, month, day).saturday?
end
puts
