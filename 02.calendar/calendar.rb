#Dateクラスとコマンドラインオプションを取得
require "optparse/date"
opt = OptionParser.new
params = ARGV.getopts("y:m:")

#年月の指定
params["y"] ||= Date.today.year
params["m"] ||= Date.today.month

#月初めの年月日
first_day = Date.new(params["y"].to_i, params["m"].to_i, 1)
#月終わりの年月日
last_day = Date.new(params["y"].to_i, params["m"].to_i, -1)
#月初めの曜日を取得
week = first_day.wday

#年月を表示
yearmonth = "#{first_day.mon}月 #{first_day.year}"
puts yearmonth.center(20)
#曜日を表示
puts "日 月 火 水 木 金 土"

#1日目の前の空白を配置
day = first_day.day
  print "".rjust(week * 3)
#日付を配置
  for day in first_day..last_day
    print "#{day.day} ".rjust(3)
    if day.saturday?
      print "\n"
    end
  end
#カレンダーの下で2回改行
print "\n" + "\n"
