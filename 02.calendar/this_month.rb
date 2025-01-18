require 'date'

# 今日の日付を取得
today = Date.today
year  = today.year
month = today.month

# 特定された月を1日から月末日を特定する（その月の日数を特定する）
first_day = Date.new(year, month, 1) # 特定の月の 1日を取得
last_day = Date.new(year, month, -1) # 特定の月の月末（最終日）
# puts "今日の日付: #{today}"
# puts "月初: #{first_day}"
# puts "月末: #{last_day}"

# 曜日の取得
today_wday = today.wday # 今日の曜日を取得
# puts "今日の曜日: #{today_wday}"

# カレンダー出力
puts "      #{month}月 #{year}"# 1行目
puts "日 月 火 水 木 金 土 " # 2行目

# ３行目以降に該当する月の日付を１ヶ月分表示する
