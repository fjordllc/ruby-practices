#!/usr/bin/ruby

require 'optparse'
require 'date'

NOW_DATE = Date.today

default_params = {
  year: NOW_DATE.year,
  month: NOW_DATE.month,
  day: NOW_DATE.day,
}

params = default_params.dup

def beginning_of_week(date)
  date.downto(date.prev_month) {|d|
    return d if d.wday == 0
  }
end

def end_of_week(date)
  date.upto(date.next_month) {|d|
    return d if d.wday == 6 
  }
end

def render(month: , year: )
  month_start = Date.new(year, month, 1)
  month_end = Date.new(year, month, -1)
  month_range = month_start .. month_end
  calendar_start = beginning_of_week(month_start)
  calendar_end = end_of_week(month_end)
  calendar_dates = calendar_start .. calendar_end
  weeks = calendar_dates.group_by {|date| date.strftime("%U").to_i}
  puts month_start.strftime("%-m月 %Y年")
  puts %w(日 月 火 水 木 金 土).join(" ")
  weeks.each do |weeknum, week|
    puts week.map {|date|
      if month_range.cover?(date)
        "%2d" % date.day
      else
        "  "
      end
    }.join(" ")
  end
end

render(month: params[:month], year: params[:year])
