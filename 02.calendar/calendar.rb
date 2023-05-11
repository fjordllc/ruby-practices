#Dateクラスを取得
require "date"
#コマンドラインオプションを取得
require "optparse"
opt = OptionParser.new
params = ARGV.getopts("-y", "-m")

if ARGV == []
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

#月初めが日曜日の場合
if week == 0
#日付に0を代入
  days = first_day.day - 1
#1週目を配置
    for days in 0..6
    days = days + 1
        print [" #{days} "].join
    end
#改行
    print "\n"
#2週目以降で日付が9までのときの配置
    for days in 7..8
      days = days + 1
        print [" #{days} "].join
    end
#2週目以降で日付が10のときの配置
    if days == 9
      days = days + 1
      print ["#{days} "].join
    end  
#2週目以降で日付が11以降の配置
    for days in 11..last_day.day
      print ["#{days} "].join
#土曜日のとき改行
      if days % 7 == 0
        print "\n"
      end
    end
end

#月初めが月曜日の場合
if week == 1
#日付に0を代入
  days = first_day.day - 1
#1日を月曜日の位置に配置
  while days < 1
    days = days + 1
      print ["    #{days}"].join
  end
#1週目の2日目以降を配置
  while days < 7 - 1
    days = days + 1
      print ["  #{days}"].join
  end
#改行
  print "\n"
#2週目以降で日付が9までのときの配置
  for days in 6..8
    days = days + 1
      print [" #{days} "].join
  end
#2週目以降で日付が10のときの配置
  if days == 9
    days = days + 1
      print ["#{days} "].join
  end
#2週目以降で日付が11以降の配置
  for days in 11..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 6
      print "\n"
    end
  end
end

#月初めが火曜日の場合
if week == 2
#日付に0を代入
  days = first_day.day - 1
#1日を火曜日の位置に配置
  while days < 1
    days = days + 1
    print ["       #{days}"].join
  end
#1週目の2日目以降を配置
  while days < 7 - 2
  days = days + 1
    print ["  #{days}"].join
  end
#改行
  print "\n"
#2週目以降で日付が9までのときの配置
  for days in 5..8
    days = days + 1
      print [" #{days} "].join
  end
#2週目以降で日付が10のときの配置
  if days == 9
    days = days + 1
      print ["#{days} "].join
  end
#2週目以降で日付が11以降の配置
  for days in 11..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 5
      print "\n"
    end
  end
end

#月初めが水曜日の場合
if week == 3
#日付に0を代入
  days = first_day.day - 1
#1日を水曜日の位置に配置
  while days < 1
    days = days + 1
    print ["          #{days}"].join
  end
#1週目の2日目以降を配置
  while days < 7 - 3
    days = days + 1
      print ["  #{days}"].join
  end
  #改行
    print "\n"
#2週目以降で日付が9までのときの配置
  for days in 4..8
    days = days + 1
      print [" #{days} "].join
  end
#2週目以降で日付が10のときの配置
  if days == 9
    days = days + 1
      print ["#{days} "].join
  end
#2週目以降で日付が11以降の配置
  for days in 11..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 4
      print "\n"
    end
  end
end

#月初めが木曜日の場合
if week == 4
#日付に0を代入
  days = first_day.day - 1
#1日を木曜日の位置に配置
  while days < 1
    days = days + 1
    print ["             #{days}"].join
  end
#1週目の2日目以降を配置
  while days < 7 - 4
    days = days + 1
      print ["  #{days}"].join
  end
  #改行
    print "\n"
#2週目以降で日付が9までのときの配置
  for days in 3..8
    days = days + 1
      print [" #{days} "].join
  end 
#2週目以降で日付が10のときの配置
  if days == 9
    days = days + 1
      print ["#{days} "].join
      print "\n"
  end
#2週目以降で日付が11以降の配置
  for days in 11..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 3
      print "\n"
    end
  end
end

#月初めが金曜日の場合
if week == 5
#日付に0を代入
  days = first_day.day - 1
#1日を金曜日の位置に配置
  while days < 1
    days = days + 1
    print ["                #{days}"].join
  end
#1週目の2日目以降を配置
  while days < 7 - 5
    days = days + 1
      print ["  #{days}"].join
  end
  #改行
    print "\n"
#2週目の配置
  for days in 2..8
    days = days + 1
      print [" #{days} "].join
  end 
  print "\n"
#3週目以降の配置
  for days in 10..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 2
      print "\n"
    end
  end
end

#月初めが土曜日の場合
if week == 6
#日付に0を代入
  days = first_day.day - 1
#1日を土曜日の位置に配置
  while days < 1
    days = days + 1
    print ["                   #{days}"].join
  end
  print "\n"
#2週目の配置
  for days in 1..7
    days = days + 1
      print [" #{days} "].join
  end 
  print "\n"
#3週目以降で日付が9までのときの配置
  if days == 8
    days = days + 1
      print [" #{days} "].join
  end 
#3週目以降の二桁のときの配置
  for days in 10..last_day.day
    print ["#{days} "].join
#土曜日のとき改行
    if days % 7 == 1
      print "\n"
    end
  end
end

#カレンダーの下で2回改行
print "\n" + "\n"
