#!/usr/bin/env ruby

require 'date'
require 'optparse'

opt = OptionParser.new

today = Date.today
year = today.year   #年の初期値
month = today.month   #月の初期値

opt.on('-m month'){|v| month = v }
opt.on('-y year'){|v| year = v }
# opt.on('-m')だけだとtrueしか返さないので、'-m'の後に何の値かを示す引数（month）が必須

opt.parse!(ARGV) #これがないと引数が渡されないみたい

#カレンダーのタイトル
def title (month, year)
  month_string =  "#{month}月".rjust(9)
  year_string = year.to_s.rjust(6)
  puts "#{month_string}#{year_string}"
end

#1ヶ月分の日付
def date(month, year)
  space = " ".rjust(3)
  month = month.to_i
  year = year.to_i
  start_date = Date.new(year, month, 1)
  end_date = Date.new(year, month, -1) #何日まであるか

  print space * start_date.wday #曜日分スペースを入れる

  #ここから日付
  (start_date..end_date).each do |date|
    date_string = date.day
    date_day = date.wday 

    print date_string.to_s.rjust(3)
    puts if date_day == 6  #土曜(0)になったら改行
  end
end

####出力部####
#タイトル
title(month, year)
#曜日
puts " 日 月 火 水 木 金 土 "
#日付
date(month, year)
