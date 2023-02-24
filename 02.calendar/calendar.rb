#!/usr/bin/env ruby

require 'date'
require 'optparse'
require 'Time'

# 今日の日付
date = Date.today
# 本日の色付け
# 今日の年
y_date = date.year
# 今日の月
m_date = date.month

# オプション設定
opt = OptionParser.new
opt.on('-m [manth]', '月を指定します-m') { |m| m_date = m.to_i }
opt.on('-y [year]', '年を指定します -y') { |y| y_date = y.to_i }
opt.parse!(ARGV)

# 今月1日
date_first = Date.new(y_date, m_date, 1)
# 今月末日
date_end = Date.new(y_date, m_date, -1)
# 最初の列の曜日を合わせるための空白数をカウント
# count =  date_first.wday

# 今月のカレンダー
# 一文字ごとの右寄＞s.rjust(10)
puts "          #{m_date}月 #{y_date}"
puts '日  月  火  水  木  金  土'.rjust(21)

# 最初の行の左から表示月の曜日までの空白分をカウント＞挿入
count =  date_first.wday

count.times do
  print ' '.rjust(4)
end

# カレンダー表記
(date_first..date_end).each do |carendar|
  print(carendar.day.to_s.rjust(4))
  # 曜日 wday 6で改行
  if carendar.wday == 6
    print("\n")
  end
end
