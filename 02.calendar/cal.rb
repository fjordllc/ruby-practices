#! /usr/bin/env ruby

require 'date'
require 'optparse'

opt = OptionParser.new

opt_year = nil
opt_month = nil

# 年と月を取得
opt.on('-y int') { |val| opt_year = val.to_i }
opt.on('-m int') { |val| opt_month = val.to_i }
opt.parse!(ARGV)

# 引数を指定しない場合は、今年・今月のカレンダーを表示させる
opt_year = Date.today.year if opt_year.nil?
opt_month = Date.today.month if opt_month.nil?

# カレンダーの「dd月 yyyy年」部分を表示
puts("      #{opt_month}月 #{opt_year}")

# 曜日を表示
days = %w[日 月 火 水 木 金 土]
puts(days.join(' '))

# 対象月の１日目の曜日を取得し、前に半角スペースを出力
first_day = Date.new(opt_year, opt_month, 1)
first_date_of_day = first_day.wday
print(' ' * 3 * first_date_of_day)

last_day = Date.new(opt_year, opt_month, -1)
# 日にちを出力
(first_day..last_day).each_with_index do |date, idx|
  # 今日の日付の部分の色を反転させる
  print("\e[0m")
  print(' ') if date.wday > 0 && idx > 0
  print("\e[7m") if date == Date.today

  # 土曜だった場合は、出力方法を変える
  if date.saturday?
    puts(date.day.to_s.rjust(2))
  else
    print(date.day.to_s.rjust(2))
  end
end

puts
