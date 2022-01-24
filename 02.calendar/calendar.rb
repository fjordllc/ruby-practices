#!/usr/bin/env ruby

require 'date'
require 'optparse'

# 日付フォーマットの適用
def form_day(day)
  if day < 10
    return " " + day.to_s(10)
  else
    return day.to_s(10)
  end
end

# 対象月の日にちをまとめる
def days_list(end_day)
  day = 1
  days_list = []

  end_day.times do
    days_list.push(form_day(day))
    day += 1
  end

  return days_list
end

# 第1週目のスペース挿入
def add_start_space(start_wday, days_list)
  start_wday.times do
    days_list.unshift("  ")
  end

  return days_list
end

# 対象年の確定
def target_year(year)
  if year == ""
    return Date.today.year
  end

  if 1970 <= year.to_i(10) && year.to_i <= 2100
    return year.to_i(10)
  else
    puts "不適切な値です！"
    exit!
  end
end

# 対象月の確定
def target_month(month)
  if month == ""
    return Date.today.month
  end

  if 1 <= month.to_i(10) && month.to_i <= 12
    return month.to_i(10)
  else
    puts "不適切な値です！"
    exit!
  end
end

# 引数取得
opt = OptionParser.new
opt_year = ""
opt.on('-y [YEAR]') do |value|
  opt_year = value
end

opt_month = ""
opt.on('-m [MONTH]') do |value|
  opt_month = value
end

opt.parse(ARGV)


# カレンダー情報
year = target_year(opt_year)
month = target_month(opt_month)
start_date = Date.new(year, month, 1)
end_date = Date.new(year, month, -1)

days = days_list(end_date.day)
calendar = add_start_space(start_date.wday, days)

# 年月表示
puts "      " + form_day(start_date.month) + "月 " + start_date.year.to_s

# 曜日表示
WEEK = ["日", "月", "火", "水", "木", "金", "土"]
puts WEEK.join(" ")

# 日表示
week = []
day = 1
calendar.each do |x|
  week.push(x)
  if day % 7 == 0
    puts week.join(" ")
    week = []
  end

  day += 1
end
if week.length != 0
  puts week.join(" ")
end
