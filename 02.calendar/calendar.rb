#Dateクラスを取得
require "date"
#コマンドラインオプションを取得
require "optparse"
opt = OptionParser.new
params = ARGV.getopts("y:m:")

#年月の指定
if params["y"] == nil
  params["y"] = Date.today.year
end
if params["m"] == nil
  params["m"] = Date.today.month
end
ARGV.push(params["y"], params["m"])

#月初めの年月日
first_day = Date.new(ARGV.first.to_i, ARGV.last.to_i, 1)
#月終わりの年月日
last_day = Date.new(ARGV.first.to_i, ARGV.last.to_i, -1)
#月初めの曜日を取得
week = first_day.wday

#年月を表示
yearmonth = "#{first_day.mon}月 #{first_day.year}"
puts yearmonth.center(20)
#曜日を表示
puts "日 月 火 水 木 金 土"

#1日目の前の空白を配置
days = first_day.day
      print "".rjust(week * 3)
#日付を配置
    for days in 1..last_day.day
      print "#{days} ".rjust(3)
#土曜日のとき改行
      if (days + week) % 7 == 0
        print "\n"
      end
    end

#カレンダーの下で2回改行
print "\n" + "\n"
