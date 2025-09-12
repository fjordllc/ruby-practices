require 'date'

print "年を入力してください"
year = gets.chomp.to_i
print "月を入力してください"
month = gets.chomp.to_i

if year < 1970 || year > 2100 || month < 1 || month > 12
    puts "年は1970から2100まで、月は1から12までの範囲で入力してください"
    exit
end

first_day = Date.new(year, month, 1)
first_day_wday = first_day.wday
last_day = Date.new(year, month, -1).day


#年と月を表示
puts "     #{year}年#{month}月"

#曜日ヘッダーを表示
puts "日 月 火 水 木 金 土"

#最初の週の空白を表示
for i in 0..(first_day_wday - 1)
    print "   "
end

for i in 1..last_day
    print "#{i.to_s.rjust(2)} "
    if (i + first_day_wday)% 7 == 0
        print "\n"
    end
end


