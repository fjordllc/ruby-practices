require 'date'
require 'optparse'

year_and_month = {}
opt = OptionParser.new
opt.on('-m value') { |month| year_and_month[:month] = month.to_i }
opt.on('-y value') { |year| year_and_month[:year] = year.to_i }
opt.parse!(ARGV)

#入力がなかった場合、今日の日付にする
today = Date.today
year = year_and_month[:year] ? year_and_month[:year] : today.year
month = year_and_month[:month] ? year_and_month[:month] : today.month

entered_day  = Date.new(year, month)
first_day = Date.new(entered_day.year, entered_day.month, 1)
last_day = Date.new(entered_day.year, entered_day.month, -1)


#calendarを表示
week_day_box = Array.new(7)
puts "      #{entered_day.month}月 #{entered_day.year}"
puts "日 月 火 水 木 金 土"
print  "   " * (first_day.cwday) unless first_day.sunday?
(first_day..last_day).each do |date|
  day = date.day
  if today.day == day
    print " " * (2 - day.to_s.length) + "\e[7m#{day}\e[0m"
  else
    print "#{day}".rjust(2)
  end
  print " "
  puts "" if date.saturday?
end
puts
