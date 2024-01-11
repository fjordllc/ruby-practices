#!/usr/bin/env ruby

require 'date'
require 'optparse'

# デフォルトを今月、今年に設定
year = Date.today.year
month = Date.today.month

# コマンドラインオプションを受け取り、引数があればデフォルト値から変更
opt = OptionParser.new

opt.on('-y [VAL]') {|y|
if y 
  year = y.to_i
end
}

opt.on('-m [VAL]') {|m|
if m 
  month = m.to_i
end
}

opt.parse!(ARGV)

# 変数を元に日付情報を取得
calendar = Date.new(year, month)

# 月と年を表示
puts "#{calendar.month.to_s.rjust(7)}月 #{calendar.year.to_s}"

# 曜日を表示
puts "日 月 火 水 木 金 土"

# 日曜始まりでは無い時の空白を調整
if calendar.strftime('%a') != "Sun"
    print  " " * (3 * calendar.wday - 1)
end 

while calendar.month == month
  if  calendar.strftime('%a') == "Sun"
    day_string = calendar.day.to_s.rjust(2)
  else  
    day_string = calendar.day.to_s.rjust(3)
  end
  if  calendar.strftime('%a') == "Sat"
    puts day_string
  else
    print day_string
  end
  calendar += 1
  end

puts ""
