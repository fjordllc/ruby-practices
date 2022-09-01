require 'date'

year_def = Date.today.year
month_def = Date.today.mon

require 'optparse'
opt = OptionParser.new

opt.on('-y') {|v|}
opt.on('-m') {|v|}

opt.parse!(ARGV)

year = ARGV[0].to_i
month = ARGV[1].to_i

#引数がない場合は今月のカレンダーを表示
if year == 0
  year = year_def
end

if month == 0
  month = month_def
end

title = "#{year}年#{month}月"
first_date = Date.new(year,month,1).day
last_date = Date.new(year,month,-1).day
firstday_dow = Date.new(year,month,1).wday
week = ["日","月","火","水","木","金","土"]

puts title.center(20)
puts week.join(" ")
print "   " * firstday_dow

wday = firstday_dow
(1..last_date).each do |date|
  print date.to_s.rjust(2) + " "
  wday = wday + 1
  if wday % 7 == 0    #土曜日(7の倍数)で改行
    print "\n"
  end
end
if wday % 7 != 0
  print "\n"
end