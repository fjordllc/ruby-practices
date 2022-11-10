#!/usr/bin/env ruby
require "date"
require "optparse"

First = 1
Last = -1
Space_num = 3
Zero_position = 0
Sunday = 7
Weeks_first_youbi = Sunday
Saturday = 6
Day_Nine = 9

# 一週目の1日までの間にスペースを置く
def print_space(first_youbi)
  if first_youbi == Sunday
    youbi_position = Zero_position
  else
    youbi_position = first_youbi * Space_num
  end
  space = " " * (youbi_position)
  print space
end

def print_colored_day(day)
  print "\e[7m"
  print day
  print "\e[0m"
end

def print_day(year, month, day)
  if Date.parse("#{year}-#{month}-#{day}") == Date.today
    print_colored_day(day)
  else
    print day
  end
end

def saturday?(youbi_index)
  youbi_index % Weeks_first_youbi == Saturday ? true : false
end

def option_perse
  opt = OptionParser.new
  opt.on("-m month","取得する月を指定します。指定しない場合は現在の月を表示します。")
  opt.on("-y year","取得する年を指定します。指定しない場合は現在の年を表示します。")
  opt.banner = "Usage: calendar [-m][-y]"
  opt.parse(ARGV)

  m_option_count = 0
  y_option_count = 0
  now_option = ""
  month = ""
  year = ""

  ARGV.each do |option|
    if option == "-m" or option == "-y"
      now_option = option
      next
    elsif now_option == "-m"
      m_option_count += 1
      raise "mオプションに指定できる引数は１つです" if m_option_count >= 2
      month = option
    elsif now_option == "-y"
      y_option_count += 1
      raise "yオプションに指定できる引数は１つです" if y_option_count >= 2
      year = option
    else
      raise "不明なオプションです"
    end
  end
  return month ,year
end

#コマンドラインから引数を取得
month,year = option_perse

# 引数がなければ現在の年、月を取得
year = Date.today.year if year == ""
month = Date.today.month if month == ""

year = year.to_i
month =month.to_i

#対象の月の1日を取得
first_day = Date::parse("#{year}-#{month}-#{First}")
#対象の月の1日の曜日を計算
first_youbi = first_day.cwday

#対象の月の末日を取得
last_day = Date.new(year, month, Last).day

#カレンダー表示
puts "#{year}年#{month}月"
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")
print_space(first_youbi)
youbi_index = first_youbi
(First..last_day).each do |day|
  print " " if day <= Day_Nine  ## 1~9日はスペースを追加
  print_day(year, month, day)
  print " "
  # 週の切り替わり計算
  print "\n" if saturday?(youbi_index)
  youbi_index += 1
end
puts "" #zshがつける不要な%を消す
