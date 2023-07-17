require 'date'
require 'optparse'

year_and_month = {}
opt = OptionParser.new
opt.on('-m value') { |month| year_and_month[:month] = month.to_i }
opt.on('-y value') { |year| year_and_month[:year] = year.to_i }
opt.parse!(ARGV)

#入力がなかった場合、今日の日付にする
today = Date.today
if year_and_month.empty?
  year_and_month[:month] = today.month
  year_and_month[:year] = today.year
elsif year_and_month[:year].nil?
  year_and_month[:year] = today.year
else year_and_month[:month].nil?
  year_and_month[:month] = today.month
end

#曜日判断メソッド
def judge_day(year, month, day)
  day_of_the_week = Date.new(year, month, day).saturday?
end

entered_day  = Date.new(year_and_month[:year], year_and_month[:month])
last_day = Date.new(entered_day.year, entered_day.month, -1).day
first_day_of_the_week = Date.new(entered_day.year, entered_day.month, 1).cwday

#calendarを表示
week_day_box = Array.new(7)
puts "#{entered_day.month}月 #{entered_day.year}"
puts "日  月  火  水  木  金  土"
if first_day_of_the_week != 7
  first_day_of_the_week.times do 
    print "    "
  end
end
1.upto(last_day) do |day|
  if Date.today == Date.new(year_and_month[:year], year_and_month[:month], day)
    print "\e[31m#{day}\e[0m  "
  else
    print "#{day}  "
  end
  print " " if day.to_s.length == 1
  puts "" if judge_day(entered_day.year, entered_day.month, day)
end
