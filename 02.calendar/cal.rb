require 'date'
require 'optparse'

#今日のDateオブジェクトを変数todayに代入
today = Date.today

#出力する日付データを持たせるハッシュ変数「date」を作成 
#初期値として今日の年月日を代入
date = {year:today.year, month:today.mon, day:today.mday} 

#オプション引数で得た月と年を出力する年月に設定
opt = OptionParser.new
opt.on('-m VAL',Integer) {|m| date[:month]= m}
opt.on('-y VAL',Integer) {|y| date[:year] = y}
opt.parse(ARGV)

#出力する年月の日数を「last_day」に代入
last_day = Date.new(date[:year],date[:month],-1).mday

#出力する年月の初日の曜日の整数値を「first_yobi」に代入
first_yobi = Date.new(date[:year],date[:month],1).wday

#出力する年月が
#今日の年月と一致していたら「color_on_date」に今日の日付(整数)を代入、
#今日の年月と一致していなければ「color_on_date」にfalseを代入
if date[:year] == today.year && date[:month] == today.mon
  color_on_date = today.mday
else
  color_on_date = false
end

#月と年を出力
puts "      #{date[:month]}月 #{date[:year]}"

#曜日の名称を出力
yobi_name_list = ["日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土\n"]
yobi_name_list.each {|day_of_the_week|print day_of_the_week}

#初日の曜日に応じて日付の出力開始位置を調整
print "   " * first_yobi
#日付を出力
count = first_yobi
(1..last_day).each do |day| 
  if color_on_date == day # color_on_dateがdayと一致していたら色反転
    print "\e[30m\e[47m"
    print "#{day}".rjust(2)
    print "\e[0m"
    print " "
    count += 1
  else
    print "#{day}".rjust(2)+" "
    count += 1
  end
  if count >= 7
    print "\n"
    count = 0
  end
end

#なぜか最後に%が表示されてしまう問題への暫定策
puts ""