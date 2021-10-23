#!/Users/heureux/.rbenv/versions/2.6.5/bin/ruby

require 'optparse'
require 'date'

target_year = ''
target_month = ''
current_year = Date.today.year
current_month = Date.today.month

days = ['日','月','火','水','木','金','土']
last_date = ''
cal_title = ''
day_header = ''

# オプションの値を取得
opt = OptionParser.new
opt.on('-y')
opt.on('-m')
opt.parse!(ARGV)

ARGV = [current_year.to_s,current_month.to_s] if ARGV.empty?
target_year = ARGV[0]
target_month = ARGV[1]

last_date = Date.new(target_year.to_i, target_month.to_i, -1).strftime('%d')

# カレンダータイトル
cal_title.concat('      ' + target_month + '月 ' + target_year)

# 曜日の表示
days.each do |day|
  day_header.concat(day + ' ')
end

puts cal_title
puts day_header

# 日付部分の出力
# 初日の曜日の数字を確認し、数字x3スペース開ける
first_day_date = Date.new(target_year.to_i,target_month.to_i,1).wday
print ' ' * first_day_date * 3

(1..last_date.to_i).each do |date|
  date < 10 ? pre_space = ' ' : pre_space = ''
  # 土曜日だったら
  if Date.new(target_year.to_i,target_month.to_i,date).wday.to_i == 6
    puts pre_space + date.to_s + ' '
  else
    print pre_space + date.to_s + ' '
  end
end