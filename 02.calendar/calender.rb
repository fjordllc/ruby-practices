require 'date'
require 'optparse'

def calender(year,mon,day)

  # 月と年を、中央に表示
  puts "#{mon}月 #{year}".center(20)
  puts "日 月 火 水 木 金 土"

  # 月の初日の曜日を数字(0~6)で表す変数を定義
  firstday = Date.new(year,mon,1).wday
  # 月の末日を表す変数を定義
  lastday = Date.new(year,mon,-1).day
  # 月の初日の配置を、空欄を設けて調整するための変数を定義
  blank = "   "*firstday

  print blank
  count = 1
  # 初日~末日までを、whileで繰り返し表示
  while count <= lastday
    # 日にちが一桁の場合は、間隔調整のためにスペースを設けるif文を記載
    if count <= 9
      print " #{count} "
    else
      print "#{count} "
    end
    # 土曜日で改行するif文を記載
    new_line = firstday + count
    if new_line %7 == 0
      puts "\n"
    end
    count = count + 1
  end
end   

# オプションがない場合に、今日の日にちを表示
options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}","d:#{Date.today.day}")
# オプションで記載された数字を以下変数に代入
year = options["y"].to_i
mon = options["m"].to_i
day = options["d"].to_i

calender(year,mon,day)