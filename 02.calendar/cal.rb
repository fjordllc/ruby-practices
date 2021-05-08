require 'date'
require 'optparse'

opt = OptionParser.new

month = nil
year = nil
opt.on('-m [Month]') { |v| month = v }
opt.on('-y [Year]') { |v| year = v }

argv = opt.parse(ARGV)

date = Date.today
if month && year
  date = Date.new(year.to_i, month.to_i, 1)
elsif month && !year
  date = Date.new(date.year, month.to_i, 1)
elsif !month && year
  date = Date.new(year.to_i, date.month, 1)
else
  date = Date.new(date.year, date.month, 1)
end

cal = ""
wday = date.wday
1.upto(date.next_month.prev_day.day) do |i|
  if i == 1
    cal += "   " * wday
  elsif wday != 0
    cal += " "
  end
  if i < 10
    cal += " "
  end
  cal += i.to_s
  if wday == 6
    cal += "\n"
    wday = 0
  elsif
    wday += 1
  end
end

puts <<-EOS
      #{date.month}月 #{date.year}
日 月 火 水 木 金 土
#{cal}
EOS
