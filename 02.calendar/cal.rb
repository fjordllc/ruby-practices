require 'date'
require 'optparse'

opt = OptionParser.new

month = nil
year = nil
opt.on('-m [Month]') { |v| month = v }
opt.on('-y [Year]') { |v| year = v }

argv = opt.parse(ARGV)

date = Date.today
month ||= date.month
year ||= date.year

date = Date.new(year.to_i, month.to_i, 1)
lastday = Date.new(year.to_i, month.to_i, -1).day

cal = ''
wday = date.wday
1.upto(lastday) do |i|
  if i == 1
    cal += '   ' * wday
  elsif wday != 0
    cal += ' '
  end
  cal += ' ' if i < 10
  cal += i.to_s
  if wday == 6
    cal += "\n"
    wday = 0
  else
    wday += 1
  end
end

puts <<~CAL
      #{date.month}月 #{date.year}
日 月 火 水 木 金 土
#{cal}
CAL
