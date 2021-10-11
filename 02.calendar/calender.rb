require "Date"
require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-y [VAL]') {|v| params[:y] = v}
opt.on('-m [VAL]') {|v| params[:m] = v }
opt.parse!(ARGV,into: params)

#yの引数が設定されていなかったときにyearには本日の西暦を入れる
year = params[:y].nil? ? Date.today.year : params[:y].to_i

#mの引数が設定されていなかったときにmonthには本日の月を入れる
month = params[:m].nil? ? Date.today.month : params[:m].to_i

print "#{month}月 #{year}".center(20)
print "\n"
print("日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土","\n")

last_day = Date.new(year, month, -1).day
first_wday = Date.new(year, month, 1).wday

(1..last_day).each do |day|
  date = Date.new(year, month, day)
  day = date.day

  #1日の曜日を確認して冒頭の位置を合わせる
  if day == 1
    start_position = 3 * first_wday
    first_space = ' ' * start_position
  else
    first_space = ''
  end

  #今日の日付に色をつける
  if date == Date.today
    color_start="\e[31m"
    color_end="\e[0m"
  else
    color_start=""
    color_end=""
  end 

  print("#{color_start}#{first_space}#{day.to_s.rjust(2)}#{color_end} ")

  #土曜日の場合は改行を入れる
  if date.saturday?
    print(" \n")
  end
end
