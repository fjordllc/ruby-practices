#!/usr/bin/env ruby
require 'optparse'
require 'date'
require 'color_echo'

# オプション定義
# オプションの引数を渡されたら、その値をto_iで数字にする
option = {}
OptionParser.new do |opt|
  opt.on('-y [value]', '--year', 'gets year') {|v| option[:y] = v.to_i}
  opt.on('-m [value]', '--month', 'gets month') {|v| option[:m] = v.to_i}
  opt.parse!(ARGV)
end

# オプションで指定された値を変数に入れる
opt_year = option[:y]
opt_mon = option[:m]

# today, year, month
td = Date.today
tdy = td.year.to_i
tdm = td.month.to_i
tdd = td.day
td_date = Date.new(tdy, tdm, 1)

# 週の初めの曜日
first_wday = td_date.wday
# 月末の日付
last_date = Date.new(tdy, tdm, -1).day
# 曜日(day of the week)をスペース区切りで指定し、配列を生成する
dow = %w(日 月 火 水 木 金 土)

# オプションが指定された際の条件分岐
d = if opt_year == 0 || opt_mon == 0
      #年または月が0や数字以外を指定された場合
      td_date
    elsif opt_year && opt_mon
      #年と月が指定された場合
      Date.new(opt_year, opt_mon, 1)
    elsif opt_year
      #年が指定された場合
      Date.new(opt_year, tdm, 1)
    elsif opt_mon
      #月が指定された場合
      Date.new(tdy, opt_mon, 1)
    else
      #何も指定されなかった場合
      td_date
    end

# 上記の条件分岐を経て、カレンダー上部に表示する日付
output_date = "#{d.month}月 #{d.year}年"

# カレンダー上部に表示する日付をなんか良い感じの位置に出力する
puts output_date.center(18)
# 配列で生成したdowを空白で連結して出力
# そのままだと改行で表示されてしまう
# printでも["日", "月", "火", "水", "木", "金", "土"]と出力されてしまう
puts dow.join(" ")
# 月初の曜日をなんか良い感じの位置に出力する
print "   " * first_wday

# 初日から月末の日の間に繰り返す感じのeach文
(1..last_date).each do |date|
  # (1..last_date)から順番に取り出した値(date)を右詰で出力していく
  if date == td.day
    CE.fg(:cyan)
    print tdd.to_s.rjust(2) + " "
  else
    CE.fg(:white)
    print date.to_s.rjust(2) + " "
  end

  # 次の日付を生成しておく
  first_wday += 1
  # 1週間経ったら改行する
  if first_wday % 7 == 0
    print "\n"
  end
end

# 月末が来たらまた改行
if first_wday % 7 != 0
  print "\n"
end
