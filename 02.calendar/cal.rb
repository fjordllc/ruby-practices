require 'optparse'
require 'date'

# コマンドラインから引数を受け取る(月:-m, 年:-y)
options = ARGV.getopts("m:y:")
if options.values.none?
  mon = Date.today.mon
  year = Date.today.year
else
  mon = options["m"].to_i
  year = options["y"].to_i
end

# コマンドライン引数で受け取った年と月を表示する
cal_width = 20
puts "#{mon}月 #{year}".center(cal_width)

# 曜日を表示する
line_cwday = "日 月 火 水 木 金 土"
puts line_cwday

# 当該年月の初日から末日までの配列を作成する
last_day_number = Date.new(year, mon, -1).day
days = (1..last_day_number).to_a

# 初日の曜日の数(1-7、月曜は1)分の空欄を先頭に追加する
first_cwday_number = Date.new(year, mon).cwday
first_cwday_number.times { days.unshift(" ") }

# 配列の各要素を2桁に揃える
days = days.map {|num| num.to_s.rjust(2)}

# 日付を週毎に区切って出力
length_a_week = 7
days.each_slice(length_a_week) do |day|
  puts day.join(" ")
end
