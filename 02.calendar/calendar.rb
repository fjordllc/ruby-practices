require 'optparse'
require 'date'

# コマンドラインのオプション
opts = OptionParser.new
program_config = Hash.new
opts.on('-m value') { |v| program_config[:m] = v }
opts.on('-y value') { |v| program_config[:y] = v }
opts.parse!(ARGV)

# 年月の設定
current_time = Time.new
calendar_month = program_config[:m].nil? ? current_time.month : program_config[:m].to_i
calendar_year = program_config[:y].nil? ? current_time.year : program_config[:y].to_i

# 月の最後の日にち
first_date = Date.new(calendar_year, calendar_month, 1)
last_date = Date.new(calendar_year, calendar_month, -1)

# レイアウト
text = ' ' * first_date.wday * 3
(first_date..last_date).each do |date|
  today = date == Date.today
  text += "\n" if ((date.day + first_date.wday - 1) % 7).zero?
  text += "\e[7m" if today
  text += date.day.to_s.rjust(2)
  text += "\e[0m" if today
  text += ' '
end

# 曜日
wdays = ['日', '月', '火', '水', '木', '金', '土']

# 表示
puts "#{calendar_month}月 #{calendar_year}".center(20)
puts wdays.join(' ')
printf "#{text}\n"
