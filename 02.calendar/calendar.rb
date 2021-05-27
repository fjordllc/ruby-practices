#!/usr/bin/env ruby

#コマンドラインのオプションを取り扱う、Dateクラスを扱うためのrequire
require 'optparse'
require 'date'
require "irb"

#Dateクラスの今日という日付（年、月、日）をdateに代入
date = Date.today
#コマンドラインの引数（m:月、y:年）をgetoptsで指定。引数がハッシュとして返ってくる。
params = ARGV.getopts("", "m:#{date.month}", "y:#{date.year}")

p params

# 今月の月と年のvalueを取り出す→integerで
this_month = params.values[0].to_i
this_year = params.values[1].to_i

# 今月の始まりの日付と終わりの日付
beginning_date = Date.new(this_year, this_month, 1)
end_of_date = Date.new(this_year, this_month, -1)

# 今月の始まりの日と終わりの日
beginning_of_month = beginning_date.day.to_i
end_of_month = end_of_date.day.to_i

#今月の始まりの曜日取得
beginning_wday = beginning_date.wday

# カレンダー出力(曜日、月と年)
puts <<~TEXT
    #{this_month}月 #{this_year}
日 月 火 水 木 金 土

TEXT

#
print "   " * beginning_wday


# カレンダー日出力
(beginning_of_month..end_of_month).each do |n|
  print n.to_s.rjust(2) + " "
  beginning_wday += 1
  if beginning_wday % 7 == 0
    print "\n"
  end
end

if beginning_wday % 7 != 0
  print "\n"
end
