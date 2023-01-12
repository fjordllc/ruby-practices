#!/usr/bin/env ruby
require 'date'
require 'optparse'

opt = OptionParser.new
option = {}

opt.on('-y [v]') {|v| option[:y] = v}
opt.on('-m [v]') {|v| option[:m] = v}

opt.parse!(ARGV)

year_num = option[:y].to_i
month_num = option[:m].to_i

today = Date.today

if year_num > 0 && month_num > 0
  @run_today = Date.new(year_num, month_num)
elsif year_num > 0
  @run_today = Date.new(year = year_num, mon = today.month)
elsif month_num > 0
  @run_today = Date.new(year = today.year, mon = month_num)
else
  @run_today = Date.today
end

#指定した年月を取得
def year_date
  year_name = @run_today.year.to_s
  month_name = @run_today.month.to_s
  output_string = month_name + "月" + "\s" + year_name
end

#曜日の取得
def weeks_name
  "\s日\s月\s火\s水\s木\s金\s土"
end

#指定した年月の日数の取得
def month_days
  first_day = Date.new(@run_today.year, @run_today.month, 1)
  last_day = Date.new(@run_today.year, @run_today.month, -1)

  output_string = ""
  output_string += year_date.center(21) + "\n"
  output_string += weeks_name + "\n"
  
  # #月頭の空白処理
  output_string += "".rjust(3) * first_day.wday

  # #取得した日数の月ごとの正規化
  # #日数の繰り返し
  (first_day..last_day).each do |day|
    if day.wday == 6
      output_string += day.day.to_s.rjust(3) + "\n"
    else
      output_string += day.day.to_s.rjust(3)
    end
  end
  output_string
end

# 正規化した日数の表示
puts month_days