#! /usr/bin/env ruby

require "date"
require 'optparse'

opt = OptionParser.new

opt_year = nil
opt_month = nil

# オプションで年と月を設定
opt.on('-y int') {|val| opt_year = val.to_i }
opt.on('-m int') {|val| opt_month = val.to_i }

opt.parse!(ARGV)

# 引数を指定しない場合は、今年・今月のカレンダーを表示させる
if (opt_year == nil and opt_month == nil)
    opt_year = Date.today.year
    opt_month = Date.today.month
elsif (opt_year == nil)
    opt_year = Date.today.year
elsif (opt_month == nil)
    opt_month = Date.today.month
end

# カレンダーの「dd月 yyyy年」部分を表示
puts("      " + opt_month.to_s + "月" + " " + opt_year.to_s)

# 曜日を表示
days = ["日", "月", "火", "水", "木", "金", "土"]
days.each{|day|
    if (days.index(day) < 6)
        print(day + " ")
    else
        puts(day)
    end
}

# 対象月の１日目の曜日をintで取得
date = Date.new(opt_year, opt_month, 1)
first_date_of_day = date.wday

# １日目の前に、全角スペース１つ（日にち分）と半角スペース１つ分（日にちの区切り分）追加
for num in 1..first_date_of_day do
    print("　" + " ")
end

# 対象月の最終日を取得
last_date = Date.new(opt_year, opt_month, -1).day;

# 日にちを出力
for date in 1..last_date do
    # 曜日取得
    target = Date.new(opt_year, opt_month, date)
    day = target.wday

    # 今日の日付の部分の色を反転させる
    if (target == Date.today)
        print("\e[7m")
    else
        print("\e[0m")
    end

    # 日にちが一桁だった場合は、日にちの前に半角スペースを入れる
    if (date < 10)
        print(" ")
    end

    # 土曜日の場合、改行する
    if (day == 6)
        puts(date)
    else
        print(date)
        print(" ")
    end
end
