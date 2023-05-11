require 'optparse'
#日付ハッシュ作成
date={year:2000, month:1, day:1} 
#optオブジェクト生成
opt = OptionParser.new

#オプションを設定
opt.on('-m VAL',Integer) {|m| date[:month]= m}
opt.on('-y VAL',Integer) {|y| date[:year] = y}
opt.parse(ARGV)


puts "      #{date[:month]}月 #{date[:year]}"

Days_of_the_week = ["日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土\n"]
Days_of_the_week.each {|day_of_the_week|print day_of_the_week}
