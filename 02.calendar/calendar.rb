require 'date'
require 'optparse'

# コマンドラインでparseする
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby calendar.rb [options]"

  opts.on("-m", "--month MONTH", Integer, "Specify the month (1-12)") do |month|
    options[:month] = month
  end

  opts.on("-y", "--year YEAR", Integer, "Specify the year") do |year|
    options[:year] = year
  end
end.parse!

# 今の日付を取る
current_date = Date.today
year = options[:year] || current_date.year
month = options[:month] || current_date.month

# date enumeratorを作る
date_range = Date.new(year, month, 1)..Date.new(year, month, -1)
dates_enum = date_range.to_enum

# カレンダーを表示する
puts "\n#{Date::MONTHNAMES[month]} #{year}".center(20)
puts "日 月 火 水 木 金 土"

# 最初の日に計算する
initial_offset = dates_enum.peek.wday

# 見やすいのため
print "   " * initial_offset

# １ヶ月分表示する
dates_enum.each do |date|
  print date.day.to_s.rjust(2) + " "

  # 土曜日になったら新しいラインを作る
  puts if date.saturday?
end

puts "\n"

