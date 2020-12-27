require "date"

head = Date.today.strftime("%B %Y") #今月の月と西暦
year = Date.today.year
mon = Date.today.mon
firstday_wday = Date.new(year,mon, 1).wday #今月初めの曜日
lastday_wday = Date.new(year,mon, -1).day #今月の最終日
week = %w(Su Mo Tu We Th Fr Sa) #配列を作る表記

puts head.center(20) #頭部分を中央寄せ
puts week.join(" ") #曜日の間隔を開けるように表示
print "  " * firstday_wday #１日までの空白を表示

wday = firstday_wday
(1..lastday_wday).each do |date| #(1..last...)で指定した範囲で繰り返し
print date.to_s.rjust(2) + " " #日付を右寄せで表示
 wday = wday+1
if wday%7==0 #7の倍数で改行
 print "\n"
 end
end
if wday%7!=0
 print "\n"
end