#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

# OptionParser オブジェクト opt を生成
opt = OptionParser.new

# カレンダーに表示したい年と月
@year = Date.today.year
@month = Date.today.month

opt.on('-y [year]') do |year|
  @year = year.to_i if year
end

opt.on('-m [month]') do |month|
  @month = month.to_i if month
end

# コマンドライン(ARGV)の解析
opt.parse(ARGV)

# 何月のカレンダーか表示する
calendar_width = 20
puts "#{@month}月 #{@year}".center(calendar_width)

# 曜日を表示する
print "日 月 火 水 木 金 土\n"

# 最初の日と最後の日を変数に代入
beginning_of_month = Date.new(@year, @month, 1)
end_of_month = Date.new(@year, @month, -1)

# 日付を表示する
print ' ' * (Date.new(@year, @month, 1).wday * 3)
(beginning_of_month..end_of_month).each do |month_day|
  if month_day.saturday?
    print "#{month_day.day}\n".rjust(3)
  else
    print "#{month_day.day} ".rjust(3)
  end
end
