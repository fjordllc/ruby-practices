# frozen_string_literal: true

require 'date'
require 'optparse'

def identify_target_date(today)
  date = { year: today.year, month: today.mon, day: today.mday }

  opt = OptionParser.new
  opt.on('-m VAL', Integer) { |m| date[:month] = m }
  opt.on('-y VAL', Integer) { |y| date[:year] = y }
  opt.parse(ARGV)

  date
end

def date_validation(date)
  if date[:month] < 1 || date[:month] > 12
    :invalid_month
  elsif date[:year] < 1
    :invalid_year
  else
    :valid
  end
end

# 日付ハッシュと今日のDateオブジェクトから、カレンダー出力に必要な情報へ加工するメソッド
def processing_date(date:, today:)
  info_for_cal = {}
  info_for_cal[:month] = date[:month]
  info_for_cal[:year] = date[:year]

  info_for_cal[:day_of_the_week_of_first_day] = Date.new(date[:year], date[:month], 1).wday

  info_for_cal[:last_day] = Date.new(date[:year], date[:month], -1).mday

  # 出力する年月が今日の年月と一致していたら「:color_inverted_date」に今日の日付(整数)を設定
  info_for_cal[:color_inverted_date] = today.mday if date[:year] == today.year && date[:month] == today.mon

  info_for_cal
end

def output_cal(info_for_cal)
  puts "      #{info_for_cal[:month]}月 #{info_for_cal[:year]}"
  puts '日 月 火 水 木 金 土'
  print '   ' * info_for_cal[:day_of_the_week_of_first_day]

  (1..info_for_cal[:last_day]).each do |day|
    # color_inverted_dateがdayと一致していたら色反転
    if info_for_cal[:color_inverted_date] == day
      print "\e[30m\e[47m#{day.to_s.rjust(2)}\e[0m "
    else
      print "#{day.to_s.rjust(2)} "
    end

    print "\n" if Date.new(info_for_cal[:year], info_for_cal[:month], day).saturday?
  end

  print "\n"
end

today = Date.today
target_date = identify_target_date(today)
case date_validation(target_date)
when :invalid_month
  puts '指定された月の値は無効です。1～12の範囲で入力して下さい。'
when :invalid_year
  puts '指定された西暦の値は無効です。1以上の値を入力して下さい'
when :valid
  info_for_cal = processing_date(date: target_date, today:)
  output_cal(info_for_cal)
end
