require "debug"
#Dateクラスを取得
require "date"
#コマンドラインオプションを取得
require "optparse"
opt = OptionParser.new
params = ARGV.getopts("y:m:")
array_params = params.values

if params == {"y"=>nil, "m"=>nil}
  ARGV.push(Date.today.year, Date.today.month)
else
  ARGV.push(array_params.first.to_i, array_params.last.to_i)
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

#日付に0を代入
days = first_day.day - 1

#1週目を配置
  while days < 1
    days = days + 1
      print "#{days}".rjust(2 + week * 3) + " "
      if week == 6
        print "\n"
      end
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
