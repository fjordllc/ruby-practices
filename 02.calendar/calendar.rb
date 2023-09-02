#Dateクラスを取得
require "date"
#コマンドラインオプションを取得
require "optparse"
opt = OptionParser.new
params = ARGV.getopts("y:m:")
array_params = params.values

#年月指定の場合分け
if array_params.first != nil && array_params.last != nil
  ARGV.push(array_params.first.to_i, array_params.last.to_i)
elsif array_params.first != nil && array_params.last == nil
  puts "月を指定してください。"
  exit
elsif array_params.first == nil && array_params.last != nil
  ARGV.push(Date.today.year, array_params.last.to_i)
else
  ARGV.push(Date.today.year, Date.today.month)
end

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

#1日目を配置
days = first_day.day
      print "#{days}".rjust(2 + week * 3) + " "
      if week == 6
        print "\n"
      end
#2日目以降
    for days in 2..last_day.day
      print "#{days} ".rjust(3)
#土曜日のとき改行
      if (days + week) % 7 == 0
        print "\n"
      end
    end

#カレンダーの下で2回改行
print "\n" + "\n"
