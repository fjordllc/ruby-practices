# frozen_string_literal: true

require 'date'
require 'optparse'

TODAY = Date.today
year = TODAY.year
month = TODAY.month

def get_arg_month(arg_month)
  if /^\d+$/.match?(arg_month) && (1..12).cover?(arg_month.to_i)
    arg_month.to_i
  else
    puts "#{arg_month} is neither a month number (1..12) nor a name"
    exit
  end
end

def get_arg_year(arg_year)
  if /^\d+$/.match?(arg_year)
    if (1..9999).cover?(arg_year.to_i)
      arg_year.to_i
    else
      puts "year '#{arg_year}' not in range 1..9999"
      exit
    end
  else
    puts "not a valid year #{arg_year}"
    exit
  end
end

# コマンドライン引数の取得
OptionParser.new do |o|
  o.on('-m', '--month ITEM', 'set month') do |m|
    month = get_arg_month(m)
  end

  o.on('-y', '--year ITEM', 'set year') do |y|
    year = get_arg_year(y)
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
  print "\e[7m" if TODAY === day
  print format("%<x>2d\e[0m  ", x: day.day)
  print "\n" if day.saturday?
end

puts "\n"
