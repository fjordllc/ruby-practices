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

this_month = params.values[0].to_i
this_year = params.values[1].to_i

beginning_of_month = Date.new(this_year, this_month, 1).day.to_i
end_of_month = Date.new(this_year, this_month, -1).day.to_i

# カレンダー出力
puts <<~TEXT
    #{this_month}月 #{this_year}
日 月 火 水 木 金 土

TEXT

# binding.irb
date_of_month = [beginning_of_month]
while beginning_of_month < end_of_month
  beginning_of_month += 1
  date_of_month << beginning_of_month
end

print date_of_month
