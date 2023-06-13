# frozen_string_literal: true

require 'date'
require 'optparse'

TODAY = Date.today
year = TODAY.year
month = TODAY.month

def get_arg_month(arg_month)
  # 文字列を数値変換できない場合ArgumentError
  raise ArgumentError unless (1..12).cover?(Integer(arg_month))

  Integer(arg_month)
rescue ArgumentError
  puts "#{arg_month} is neither a month number (1..12) nor a name"
  exit
end

def get_arg_year(arg_year)
  # 文字列を数値変換できない場合ArgumentError
  if (1..9999).cover?(Integer(arg_year))
    Integer(arg_year)
  else
    puts "year '#{arg_year}' not in range 1..9999"
    exit
  end
rescue ArgumentError
  puts "not a valid year #{arg_year}"
  exit
end

# コマンドライン引数の取得
OptionParser.new do |o|
  o.on('-m', '--month ITEM', 'set month') do |m|
    month = get_arg_month(m)
  end

  o.on('-y', '--year [ITEM]', 'set year') do |y|
    year = get_arg_year(y) unless y.nil?
  end
  o.on('-h', '--help', 'show this help') do
    puts o
    exit
  end
  o.parse!(ARGV)
rescue OptionParser::InvalidOption => e
  puts e.message
  exit
rescue OptionParser::MissingArgument => e
  puts "option requires an argument -- '#{e.args[0].chars[-1]}'"
  exit
end

print format("　　　　　%<m>2d月  %<y>4d \n", m: month, y: year)
puts '日　月　火　水　木　金　土'

# 月初日の曜日分だけ、スペースを出力
Date.new(year, month, 1).wday.times { print '　　' }

(Date.new(year, month, 1)..Date.new(year, month, -1)).each do |day|
  print "\e[7m" if TODAY.eql?(day)
  print format("%<x>2d\e[0m  ", x: day.day)
  print "\n" if day.saturday?
end

puts "\n"
