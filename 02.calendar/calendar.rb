require 'optparse'
require 'date'

# コマンドラインのオプション
opts = OptionParser.new
program_config = Hash.new
opts.on('-m value') { |v| ProgramConfig[:m] = v }
opts.on('-y value') { |v| ProgramConfig[:y] = v }
opts.parse!(ARGV)

# デフォルトの年月
current_time = Time.new
calendar_year = current_time.year.to_i
calendar_month = current_time.month.to_i

# オプションがある時の年月
calendar_month = ProgramConfig[:m].to_i unless ProgramConfig[:m].nil?
calendar_year = ProgramConfig[:y].to_i unless ProgramConfig[:y].nil?

# 月の初めの曜日
start_wday = Date.new(calendar_year, calendar_month, 1).wday

# 月の最後の日にち
last_date = Date.new(calendar_year, calendar_month, -1).day

# レイアウト
text = ' ' * start_wday * 3
(1..last_date).each do |date|
  today = calendar_year == current_time.year && calendar_month == current_time.month && date == current_time.day
  text += "\n" if ((date + start_wday - 1) % 7).zero?
  text += "\e[37m\e[40m" if today
  text += date.to_s.length == 1 ? date.to_s.rjust(2) : date.to_s
  text += "\e[0m" if today
  text += ' '
end

# 曜日
wdays = ['日', '月', '火', '水', '木', '金', '土']

# 表示
puts "#{calendar_month}月 #{calendar_year}".center(20)
puts wdays.join(' ')
printf text += "\n"
