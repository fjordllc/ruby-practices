# frozen_string_literal: true

require 'date'
require 'optparse'

TODAY = Date.today
year = TODAY.year
month = TODAY.month

# コマンドライン引数の取得
options = {}
OptionParser.new do |o|
  o.on('-m', '--month [ITEM]', 'set month') { |v| options[:month] = v }
  o.on('-y', '--year [ITEM]', 'set year') { |v| options[:year] = v }
  o.on('-h', '--help', 'show this help') { puts o; exit }
  o.parse!(ARGV)
rescue OptionParser::InvalidOption => e
  puts e.message
  exit
rescue SystemExit
  exit
end

if !options[:month].nil?
  if (1..12).cover?(options[:month].to_i)
    month = options[:month].to_i
  else
    begin
      puts "'#{options[:month]}' is neither a month number (1..12) nor a name"
      exit
    rescue SystemExit
      exit
    end
  end
end

if !options[:year].nil?
  if (1..9999).cover?(options[:year].to_i)
    year = options[:year].to_i
  else
    begin
      Integer(options[:year]) # 文字列を数値変換できない場合ArgumentError
      puts " year '#{options[:year]}' not in range 1..9999"
      exit
    rescue ArgumentError
      puts "not a valid year '#{options[:year]}'"
      exit
    rescue SystemExit
      exit
    end
  end
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
