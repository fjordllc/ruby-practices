require 'optparse'
require "date"

#コマンドラインのオプション
opt = OptionParser.new
opt.on('-m') {|v| p v }
opt.on('-y') {|v| p v }

#デフォルトの年月
time = Time.new
calendar_year = time.year
calender_month = time.month

#オプションがある時の年月
unless ARGV[1].nil?
  calender_month = ARGV[1]
  unless ARGV[3].nil?
    calendar_year = ARGV[3]
  end
end

#月の初めの曜日
start_of_wday = Date.new(calendar_year.to_i, calender_month.to_i, 1).wday

#月の最後の日にち
end_of_month = Date.new(calendar_year.to_i, calender_month.to_i, -1).day

#レイアウト
text = " "*start_of_wday*3
1.upto(end_of_month) do |num|
  text += "\n" if (num + start_of_wday -1) % 7 == 0
  text += " " if num.to_s.length == 1
  text += num.to_s+ " "
end

#曜日
wdays = ["日", "月", "火", "水", "木", "金", "土"]

#表示
puts "      #{calender_month}月 #{calendar_year}"
puts wdays.join(' ')
puts text

