require 'optparse'
require 'date'

todaymonth = Date.today.month
todayyear = Date.today.year
puts "      " + todaymonth.to_s + "月" + " " + todayyear.to_s
japanese_wdays = ["日", "月", "火", "水", "木", "金", "土"]
puts japanese_wdays.join(" ")

# 表示する年月を取得

# 引数の年月から日付配列を作成


# 引数をカレンダーに整形後、表示するstrを配列に入れて返す

# 処理実行
