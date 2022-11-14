#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

SPACE_NUM_FOR_DAY = 3
SUNDAY = 7
LEFT_EDGE_YOUBI_INDEX = 7
SATURDAY = 6

# 一週目の1日までの間にスペースを置く
def print_space_to_first(first_youbi)
  youbi_position = first_youbi == SUNDAY ? 0 : first_youbi * SPACE_NUM_FOR_DAY
  space = ' ' * youbi_position
  print space
end

def print_today(day)
  print "\e[7m"
  print day
  print "\e[0m"
end

def print_day(year, month, day)
  str_day = day.to_s.rjust(2)
  if Date.parse("#{year}-#{month}-#{day}") == Date.today
    print_today(str_day)
  else
    print str_day
  end
end

def saturday?(youbi_index)
  youbi_index % LEFT_EDGE_YOUBI_INDEX == SATURDAY
end

def get_option(argv)
  result = {}
  option_count = 0
  now_option = ''
  argv.each do |option|
    if ['-y', '-m'].include?(option)
      now_option = option[1]
    else
      option_count += 1
      raise "#{now_option}オプションに指定できる引数は１つです" if option_count >= 2

      result[now_option] = option
      option_count = 0
    end
  end
  result
end

def parse_option
  opt = OptionParser.new
  opt.on('-m month', '取得する月を指定します。指定しない場合は現在の月を表示します。')
  opt.on('-y year', '取得する年を指定します。指定しない場合は現在の年を表示します。')
  opt.banner = 'Usage: calendar [-m][-y]'
  opt.parse(ARGV)
  get_option(ARGV)
end

def print_calendar(year, month)
  # 対象の月の1日を取得
  first_day = Date.parse("#{year}-#{month}-1")
  # 対象の月の1日の曜日を計算
  first_youbi = first_day.cwday
  # 対象の月の末日を取得
  last_day = Date.new(year.to_i, month.to_i, -1).day
  puts "#{year}年#{month}月"
  puts %w[日 月 火 水 木 金 土].join(' ')
  print_space_to_first(first_youbi)
  youbi_index = first_youbi
  (1..last_day).each do |day|
    print_day(year, month, day)
    print ' '
    # 週の切り替わり計算
    print "\n" if saturday?(youbi_index)
    youbi_index += 1
  end
  puts '' # zshがつける不要な%を消す
end

# コマンドラインから引数を取得
options = parse_option
year    = options['y']
month   = options['m']
# 引数がなければ現在の年、月を取得
year = Date.today.year if year.nil?
month = Date.today.month if month.nil?

# カレンダー表示
print_calendar(year, month)
