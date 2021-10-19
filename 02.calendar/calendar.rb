require 'optparse'
require 'date'

params = ARGV.getopts("y:", "m:")

year = params["y"]&.to_i || Date.today.year
month = params["m"]&.to_i || Date.today.mon

START_DAY = 1
END_DAY = Date.new(year, month, -1).day

before_blank = "   " * Date.new(year, month, START_DAY).wday
after_blank =  "\n"

day_of_week_list = ["日", "月", "火", "水", "木", "金", "土"]

print "      #{month}月 #{year}      \n"

day_of_week_list.each_with_index do |day_of_week, index|
  if index == day_of_week_list.size - 1
    print day_of_week + "\n"
  else
    print day_of_week + " "
  end
end

def is_saturday?(year, month, day)
  Date.new(year, month, day).wday == 6
end

def is_today?(year, month, day)
  Date.today == Date.new(year, month, day)
end

def is_one_digit?(day)
  day < 10
end

print before_blank

(START_DAY..END_DAY).each do |day|
  display_day = is_today?(year, month, day) ? "\e[30;43m#{day.to_s}\e[0m" : day.to_s
  # 土曜日かつ1桁の場合（2021年の10月なら2が該当）
  if is_one_digit?(day) && is_saturday?(year, month, day)
    print " " + display_day + "\n"
  # 2桁で土曜日で改行したい場合
  elsif is_saturday?(year, month, day)
    print display_day + "\n"
  # 1桁で土曜以外の場合
  elsif is_one_digit?(day) && !is_saturday?(year, month, day)
    print " " + display_day + " "
  # 2桁で土曜以外の場合
  else
    print display_day + " "
  end
end

print after_blank