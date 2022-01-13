#!/usr/bin/env ruby

require 'date'
require 'optparse'

# 日付フォーマットの適用
def formDay(day)
  if day < 10
    return " " + day.to_s(10)
  else
    return day.to_s(10)
  end
end

# 対象月の日にちをまとめる
def daysList(endDay)
  day = 1
  daysList = []

  endDay.times do
    daysList.push(formDay(day))
    day += 1
  end

  return daysList
end

# 第1週目のスペース挿入
def addStartSpace(startWday, daysList)
  startWday.times do
    daysList.unshift("  ")
  end

  return daysList
end

# 対象年の確定
def targetYear(year)
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
def targetMonth(month)
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
optYear = ""
opt.on('-y [YEAR]') do |value|
  optYear = value
end

optMonth = ""
opt.on('-m [MONTH]') do |value|
  optMonth = value
end

opt.parse(ARGV)


# カレンダー情報
year = targetYear(optYear)
month = targetMonth(optMonth)
startDate = Date.new(year, month, 1)
endDate = Date.new(year, month, -1)

days = daysList(endDate.day)
calendar = addStartSpace(startDate.wday, days)

# 年月表示
puts "      " + formDay(startDate.month) + "月 " + startDate.year.to_s

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
