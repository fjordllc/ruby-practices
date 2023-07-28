require 'date'

#日から土までの曜日の表示
week = ["日","月","火","水","木","金","土"]
week2 = " 日 月 火 水 木 金 土"
#曜日を一列に表示

#一ヶ月の表示
today = Date.today
puts today.strftime("%-m月 %Y").center(21)
puts week2
last_day = Date.new(today.year, today.month, -1)
last_days = last_day.day

first_day =  Date.new(today.year, today.month,)
first_wday = first_day.wday
first_wday.times do
  print "   "
end
range = 1..last_days
range.each do |a|
  if Date.new(today.year, today.month, a).wday == 6
    puts a.to_s.rjust(3)
  else
    print a.to_s.rjust(3)
  end
end
#最初の日を曜日に合わせる(もし月の初めが日曜なら日の下。月曜なら月の下....)