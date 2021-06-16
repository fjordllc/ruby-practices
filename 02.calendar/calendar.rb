require "date"

#today = Date.today

head = Date.today.strftime("%B, %Y")
year = Date.today.year
mon = Date.today.mon


#日にち＆曜日
firstday_wday = Date.new(year, mon, 1).wday
last_day = Date.new(year, mon, -1).day
week = %w(日 月 火 水 木 金 土)


#曜日設定
puts head.center(20)
puts week.join(" ")
print "   " * firstday_wday

#カレンダーっぽく表示する
wday = firstday_wday
(1..last_day).each do |date|
    print date.to_s.rjust(3) 

wday = wday + 1
    if wday % 7 == 0
        puts "\n" 
    end
end 

