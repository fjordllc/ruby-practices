require "optparse"
require "date"

params = ARGV.getopts("y:", "m:")

date = Date.today #dateは今の年月日

if !params["m"] #-mオプションがなければ今月を指定
    the_month = date.month
else
    the_month = params["m"].to_i
end

if !params["y"] #-yオプションがなければ今年を指定
    the_year = date.year
else
    the_year = params["y"].to_i
end

last_date = Date.new(the_year,the_month,-1) #last_dateは指定年月最終日
last_day = last_date.day #last_dayは指定年月の最終日
days = [last_day] #days配列[最終日のみ]
while last_day > 1
    last_day = last_day - 1
    days.unshift(last_day) #最終日から１ずつ引いた数を配列daysの先頭に追加
end 
#days配列に指定月の日付けが追加された

puts "      #{the_month}月 #{the_year}"  #指定年月を表示

wdays = ["日","月","火","水","木","金","土"]
puts wdays.join(" ") #曜日を表示

#1の前の空白を表示
date1 = Date.new(the_year,the_month,1)
blank = date1.wday * 3
blank.to_i.times { print " "}

#日付を表示
days.each do |day|
    cal_date = Date.new(the_year,the_month,day)
    case 
    when cal_date.saturday? && day < 10 #土曜日かつ10以下で改行と左スペース
        puts " #{day}"
    when cal_date.saturday? #土曜日で改行
        puts day
    when day < 10 #10以下で左右スペース
        print " #{day} "
    else #それ以外は右スペース
        print "#{day} "
    end
end

