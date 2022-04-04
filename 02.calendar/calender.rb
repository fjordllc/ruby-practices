require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-m')
opt.on('-y')
opt.parse!(ARGV)



# p ARGV
# puts "today is #{ARGV[1]}/#{ARGV[0]}"
# ARGV  引数個数判定　処理
## 引数-yがnull  -> 今年 
## 引数-yyがnull  -> 今年 


year = ARGV[1].to_i
if year == 0
    year = Date.today.year
end

month = ARGV[0].to_i
if month == 0
    month = Date.today.month
end



date = Date.new(year, month, -1)
month_last = date.to_s.slice(8..10).to_i



# カレンダーのヘッダ
puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

# 第一週の右詰
sample = Date.new(year, month, 1).wday
for i in 0..(sample-1) do
    print "   "
end

# 日付描画
for i in 1..month_last do
    
    # write day
    if i/10 == 0
        print " #{i} "
    elsif
        print "#{i} "
    end

    # 土曜日だったなら改行
    weekday = Date.new(year, month, i).wday
    if weekday == 6
        puts ""
    end
    


end