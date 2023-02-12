#!/usr/bin/env ruby

require 'optparse'
require "date"
opt = OptionParser.new
params = {}
opt.on('-y'){|year| params[:y] = year }
opt.on('-m'){|month| params[:m] = month }
opt.parse!(ARGV)

if params.empty? == false
  year = ARGV.join[0,4].to_i
  month = ARGV.join[4,2].to_i 
else
  year = Date.today.year
  month = Date.today.month
end 

date_start = Date.new(year, month, 1)
date_end = Date.new(year, month, -1)
youbi = [" 日 ", " 月 ", " 火 ", " 水 ", " 木 ", " 金 ", " 土 "]
youbi_start = date_start.wday

puts "#{month}月#{year}年".center(26) 
puts youbi.join

(date_start.day..date_end.day).each do |date|
  if youbi_start == 0  #1日が日曜日の月
    if date == 1  #1日にスペースを入れる
      print ("    " * youbi_start) + "#{date}".center(4)      
    elsif date % 7 == youbi_start  #土曜日で改行する
      print "#{date}".center(4)
      puts "\n"
    else  #土曜日以外の日はそのまま出力
      print "#{date}".center(4) 
    end
  elsif  youbi_start == 6  #1日が土曜日の月
    if date == 1  #1日にスペースを入れて、さらに改行する
      print ("    " * youbi_start) + "#{date}".center(4)      
      puts "\n"
    elsif date % 7 == 7 - youbi_start  #土曜日で改行する
      print "#{date}".center(4)
      puts "\n"
    else  #土曜日以外の日はそのまま出力
      print "#{date}".center(4)
    end
  else  #1日が土日以外の月
    if date == 1  #1日にスペースを入れる
      print ("    " * youbi_start) + "#{date}".center(4)      
    elsif date % 7 == 7 - youbi_start  #土曜日で改行する
      print "#{date}".center(4)
      puts "\n"
    else  #土曜日以外の日はそのまま出力
      print "#{date}".center(4)
    end
  end
end