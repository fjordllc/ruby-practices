#!/usr/bin/env ruby

#こんな感じで作ろうか
# *******00月*0000年*******
# *日_*月_*火_*水_*木_*金_*土



require 'date'
require 'optparse'

opt = OptionParser.new

year = 2022   #年の初期値
month = 4   #月の初期値

opt.on('-m', '--add ITEM', Integer, 'add an year') {|v| month = v }
opt.on('-y', '--add ITEM', Integer, 'add an year') {|v| year = v }

opt.parse(ARGV) #これがないと引数が渡されないみたい



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
  space = "      "
  if month.to_i > 9
    puts space + "#{month}月" + " " + "#{year}"
  else
    puts space + " #{month}月" + " " + "#{year}"
  end
end

#1週間分の曜日
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

#1ヶ月分の日付
def date(month, year)
  start_date = Date.new(year, month, 1)
  #p start_date.strftime('%a')
  def start_count (start_date)  #1日が何曜日からスタートか？
    if start_date.strftime('%u').to_i == 7
      return 0
    else
      start_date.strftime('%u').to_i
    end
  end

  start_space = start_count(start_date)

  space = "   "

  #何日まであるか
  end_date = Date.new(year, month, -1).strftime('%d')

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
days
#日付
date(month, year)
