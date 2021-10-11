require 'optparse'
require 'date'

# コマンドラインから引数を受け取る(月:-m, 年:-y)
options = ARGV.getopts("m:y:")

# 月と年(引数を省略した場合は今日の年月)を取得する
DATE_TODAY = Date.today
mon = options["m"] ? options["m"].to_i : DATE_TODAY.mon
year = options["y"] ? options["y"].to_i : DATE_TODAY.year

# 月と年を中央揃えで表示する
CAL_WIDTH = 20
puts "#{mon}月 #{year}".center(CAL_WIDTH)

# 曜日を表示する
LINE_CWDAY = "日 月 火 水 木 金 土"
puts LINE_CWDAY

# 当該年月の初日から末日までの配列を作成する
last_day = Date.new(year, mon, -1).day
days = (1..last_day).to_a

# 初日の曜日の数(1-7、月曜は1)分の空欄を先頭に追加する
first_cwday = Date.new(year, mon).cwday
first_cwday.times { days.unshift(" ") }

# 配列の各要素を2桁に揃える
days = days.map { |num| num.to_s.rjust(2) }

# 日付を週毎に区切って出力する
LENGTH_A_WEEK = 7
days.each_slice(LENGTH_A_WEEK) { |day| puts day.join(" ") }
