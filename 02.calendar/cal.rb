require 'date'
require_relative 'cal_month'

def cal
  date = Date.today
  year = date.year
  month = date.month

  mon = Month.new(year, month)

  puts "#{month}月 #{year}"
  display_day_of_week
  mon.weeks { |week| display_week(week) }
end

def display_day_of_week
  day_of_week = %w[日 月 火 水 木 金 土]
  sep = ' '
  puts day_of_week.join(sep)
end

def display_week(week)
  displayed_week = week.map { |day| display_day(day) }
  sep = ' '
  puts displayed_week.join(sep)
end

def display_day(day)
  return '  ' if day.nil?

  if day < 10
    " #{day}"
  else
    day.to_s
  end
end

cal
#week = [nil, nil, nil, 3, 4, 5, 6]
#display_week(week)
