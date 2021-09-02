#!/usr/bin/env ruby
require 'highline'
require "date"
require 'optparse'

# コマンドライン引数
options = ARGV.getopts('y:', 'm:')

# 今日の日付
today = Date.today

# 年度設定
year = ""
if options["y"]
  year = options["y"]
else
  year = today.year
end

# 月設定
month = ""
if options["m"]
  month = options["m"]
else
  month = today.month
end

# 曜日
day = ["日", "月", "火", "水", "木", "金", "土"]

# 月初
first_day = Date.new(year.to_i, month.to_i, 1)
# 月末
last_day = Date.new(year.to_i, month.to_i, -1)

# 日数カウンター
day_num_count = 1
# 出力列
row_count = first_day.wday
# 初期位置
start_position = "    " * row_count

# 本日と同年同月の場合にフラグを立てハイライトのオブジェクト作成
today_flg = false
if today.year == year && today.month == month.to_i
  today_flg = true
  h = HighLine.new
end

# -------------------
# 処理内容

# 年月出力
8.times { print " " }
puts  "#{month}月 #{year}年"

# 曜日文字列出力
day_output = day.join("  ")
puts day_output

print start_position

# 日数出力
while day_num_count <= last_day.day do
  # 10以下の場合は幅合わせのためにスペースをプリント
  print " " if day_num_count <= 9

  # フラグがありかつ今日と同じ日付の場合は色を付けて出力
  if today_flg && day_num_count == today.day
    print h.color(day_num_count.to_s, :red)
  else
    print day_num_count.to_s
  end

  # 土曜日の場合は改行し出力位置を日曜日に設定、それ以外は次の曜日に位置がうつる
  if row_count == 6
    print "\n"
    row_count = 0
  else
    print "  "
    row_count += 1
  end
  day_num_count += 1
end
print "\n"
