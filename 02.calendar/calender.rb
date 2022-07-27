require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-m')
opt.on('-y')
opt.parse!(ARGV)

year = ARGV[1].to_i
year = Date.today.year if year == 0

month = ARGV[0].to_i
month = Date.today.month if month == 0

date = Date.new(year, month, -1)
month_last = date.to_s.slice(8..10).to_i

# カレンダーのヘッダ
puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

# 第一週の右詰
first_date = Date.new(year, month, 1).wday
for i in 0..(first_date-1) do
    print "   "
end

# 日付描画
for i in 1..month_last do
    # write day
    print format("%02d ", i)

    # 土曜日だったなら改行
    weekday = Date.new(year, month, i).wday
    puts "" if weekday == 6
end
