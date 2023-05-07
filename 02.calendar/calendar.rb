require 'date'
day = Date.today
year = day.year
month = day.month
require 'optparse'
opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }
opt.parse!(ARGV)
puts "\x1B[36;1m#{month}\x1B[37;m月\x1B[36;1m#{year}\x1B[37;m".rjust(38)
puts "日 月 火 水 木 金 土"
end_of_date = Date.new(year, month, -1).day
start_of_date = Date.new(year, month, 1).wday
youbi = 0
while youbi < start_of_date
  youbi += 1
  if youbi == 1
    print " ".rjust(2)
  else
    print " ".rjust(3)
  end
end
today = day.day
num = 0
while num < end_of_date do
  num += 1
  case 
  when num == today
    print "\x1B[31;1m#{num}\x1B[37;m".rjust(15)
  when (youbi)%7 == 0 && num < 10
    print "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
  when (youbi)%7 == 0 
    print "\x1B[36;1m#{num}\x1B[37;m"
  else 
    print " " + "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
  end
  if ((youbi+=1)%7 == 0)
    puts
  end
end