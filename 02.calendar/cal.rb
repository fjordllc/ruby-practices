# frozen_string_literal: true

require 'date'
require 'optparse'

def identify_target_date(today)
  target_date = { year: today.year, month: today.mon, day: today.mday }

  opt = OptionParser.new
  opt.on('-m VAL', Integer) { |m| target_date[:month] = m }
  opt.on('-y VAL', Integer) { |y| target_date[:year] = y }
  opt.parse(ARGV)

  target_date
end

def invalid_month?(target_date)
  target_date[:month] < 1 || target_date[:month] > 12
end

def invalid_year?(target_date)
  target_date[:year] < 1
end

def output_cal(date:, today:)
  puts "      #{date[:month]}月 #{date[:year]}"
  puts '日 月 火 水 木 金 土'
  print '   ' * Date.new(date[:year], date[:month], 1).wday

  last_day = Date.new(date[:year], date[:month], -1).mday
  
  (1..last_day).each do |day|
    output_date = Date.new(date[:year], date[:month], day)
    if output_date == today
      print "\e[30m\e[47m#{day.to_s.rjust(2)}\e[0m "
    else
      print "#{day.to_s.rjust(2)} "
    end
    print "\n" if output_date.saturday?
  end
  print "\n"
end

today = Date.today
target_date = identify_target_date(today)

if invalid_month?(target_date)
  puts '指定された月の値は無効です。1～12の範囲で入力して下さい。'
elsif invalid_year?(target_date)
  puts '指定された西暦の値は無効です。1以上の値を入力して下さい'
else
  output_cal(date: target_date, today:)
end
