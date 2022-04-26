#!/usr/bin/env ruby

#こんな感じで作ろうか
# *******00月*0000年*******
# *日_*月_*火_*水_*木_*金_*土



require 'date'
require 'optparse'

opt = OptionParser.new

year = 2022   #年の初期値
month = 4   #月の初期値

# ショートオプションのみならopt.on('-m')で平気！
#opt.on('-m', '--add ITEM', Integer, 'add an year') {|v| month = v }
#opt.on('-y', '--add ITEM', Integer, 'add an year') {|v| year = v }

opt.on('-m month'){|v| month = v }
opt.on('-y year'){|v| year = v }
# opt.on('-m')だけだとtrueしか返さないので、'-m'の後に何の値かを示す引数（month）が必須

opt.parse!(ARGV) #これがないと引数が渡されないみたい



#binding.irb
#p month
#p year

=begin

puts a = Date.new(year, month, 1)
puts a.strftime('%a')

# %u: 月曜日を1とした、曜日の数値表現 (1..7)
puts start_day = a.strftime('%u').to_i 
# カレンダーのスタートまでstart_spaceの数だけスペースを入れる


puts Date.new(2022, 4, 7).strftime('%U')


puts "-----------------------------------------------"
puts "カレンダー"

=end

#カレンダーのタイトル
def title (month, year)
  puts "#{month}月".rjust(9) + "#{year}".rjust(6)
end

#1週間分の曜日
=begin
def days
  week = [" 日", "月", "火", "水", "木", "金", "土"]
  week.each do |day|
    if day == week.last
      print day
    else
      print day + " "
    end
  end
  puts " "
end
=end

#1ヶ月分の日付
def date(month, year)
  space = "   "
  month = month.to_i
  year = year.to_i
  start_date = Date.new(year, month, 1)
  start_space = start_date.wday #1日が何曜日からスタートか？

  end_date = Date.new(year, month, -1).day #何日まであるか

  date = 1
  start_space.times{  #曜日分スペースを入れる
    print space
  }
  x = start_space +1  #スペース数+1からスタート
  y = start_space.to_i + end_date.to_i  #スペース数+最終日まで

  #ここから日付
  while x <= y
    if x % 7 ==0  #7の倍数で改行する
      if date >9
        print " " + "#{date}\n"
      else
        print " " + " " + "#{date}\n"
      end
      
    else
      if date >9
        print " " + "#{date}"
      else
        print " " + " " + "#{date}"
      end
    end
    date += 1
    x += 1
  end
end


####出力部####
#タイトル
title(month, year)
#曜日
#days
puts " 日 月 火 水 木 金 土 " # これで十分
#日付
date(month, year)
