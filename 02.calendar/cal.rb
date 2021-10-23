#!/Users/heureux/.rbenv/versions/2.6.5/bin/ruby

require 'optparse'
require 'date'

current_year = Date.today.year
current_month = Date.today.month

opt = OptionParser.new

target_year = ''
target_month = ''
days = ['日','月','火','水','木','金','土']
last_date = ''
dates = ''

cal_title = ''
day_header = ''

opt.on('-y')
opt.on('-m')

opt.parse!(ARGV)

if ARGV.empty?
  argument = [current_year.to_s,current_month.to_s]
else
  argument = ARGV
end
target_year = argument[0]
target_month = argument[1]


last_date = Date.new(target_year.to_i, target_month.to_i, -1).strftime('%d')

cal_title.concat('      ' + target_month + '月 ' + target_year)


days.each do |day|
  day_header.concat(day + ' ')
end


first_day_date = Date.new(target_year.to_i,target_month.to_i,1).wday

puts cal_title
puts day_header

# 日付部分
# 初日の曜日を確認し、必要な曜日数x3スペース開ける
print dates.concat(' '* first_day_date * 3)

(1..last_date.to_i).each do |date|
  date < 10 ? pre_space = ' ' : pre_space = ''
  # 土曜日だったら
  if Date.new(target_year.to_i,target_month.to_i,date).wday.to_i == 6
    puts pre_space + date.to_s + ' '
  else
    print pre_space + date.to_s + ' '
  end
end