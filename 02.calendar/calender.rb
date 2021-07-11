require "Date"
require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-y [VAL]') {|v| params[:y] = v}
opt.on('-m [VAL]') {|v| params[:m] = v }
opt.parse!(ARGV,into: params)

#yの引数が設定されていなかったときにyearには本日の西暦を入れる
if params[:y] != nil
  year = params[:y].to_i
else
  year = Date.today.year.to_i
end

#mの引数が設定されていなかったときにmonthには本日の月を入れる
if params[:m] != nil
  month = params[:m].to_i
else
  month = Date.today.month.to_i
end

print "      #{month}月 #{year}\n"
print("日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土","\n")

count = 1
last = Date.new(year, month, -1).day
first_wday = Date.new(year, month, 1).wday

while count <= last
  date = Date.new(year, month, count)
  day = date.day

  #1日の曜日を確認して冒頭の位置を合わせる
  if count == 1
    start_position = 3 * first_wday
    first_space = ''
    start_position.times do
      first_space = first_space + ' '
    end
  else
    first_space = ''
  end
  
  #一桁の場合は数字の前に余白をつける
  if day.to_s.length == 1
    space = ' '
  else
    space = ''
  end

  #今日の日付に色をつける
  if date == Date.today
    color_start="\e[31m"
    color_end="\e[0m"
  else
    color_start=""
    color_end=""
  end 

  #土曜日の場合は改行を入れる
  if date.saturday?
    print("#{color_start}#{first_space}#{space}#{day}#{color_end} \n")
  else
    print("#{color_start}#{first_space}#{space}#{day}#{color_end} ")
  end

  count = count + 1
end
