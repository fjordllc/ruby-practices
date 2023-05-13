require 'date'
require 'optparse'

#今日のDateオブジェクトを変数todayに代入
today = Date.today

#日付ハッシュ「date」を作成 (初期値として今日の日付を代入)
date = {year:today.year, month:today.mon, day:today.mday} 

#optオブジェクト生成
opt = OptionParser.new

#オプション引数で得た月と年をdateに設定
opt.on('-m VAL',Integer) {|m| date[:month]= m}
opt.on('-y VAL',Integer) {|y| date[:year] = y}
opt.parse(ARGV)

puts "      #{date[:month]}月 #{date[:year]}"

Days_of_the_week = ["日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土\n"]
Days_of_the_week.each {|day_of_the_week|print day_of_the_week}
