require 'date'
require 'optparse'

params = ARGV.getopts("y:","m:")
year = (params["y"] || Date.today.year).to_i # str型だとDate.new出来ないので
month = (params["m"] || Date.today.month).to_i

start_day = Date.new(year,month,1)
end_day = Date.new(year,month,-1)

puts "#{month}月 #{year}".center(20)
puts " 日 月 火 水 木 金 土"
# wdayの日曜日は0:int型になる
# カレンダーのスタートは日曜日から始まる
# なので、最初に改行なしの空白を差し込めば、その曜日から出力を行える
print "   " * start_day.wday
# 月の最初の日から、最後の日までループを回す
(start_day..end_day).each{ |day|
  # 土曜日でなければ、改行無しで出力
  print day.day.to_s.rjust(3) unless day.wday == 6
  # 土曜日は改行を行って出力
  puts day.day.to_s.rjust(3) if day.wday == 6
}
