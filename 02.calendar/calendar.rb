require 'date'
require 'optparse'

def write(year, month)
  wday_number = Date.new(year, month, 1).wday
  puts "      #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"
  print '   ' * wday_number
  (1..(Date.new(year, month, -1).mday)).each do | day |
    print ' ' if day.to_s.size == 1
    print "#{day} "
    print "\n" if (wday_number + day) % 7 == 0
  end
end

params = ARGV.getopts("m:", 'y:')

month = 
  if params["m"].nil?
    Date.today.month
  else
    params["m"].to_i
  end

year = 
  if params["y"].nil?
    Date.today.year
  else
    params["y"].to_i
  end

begin
  BaseDay = Date.new(year, month, 15)
rescue => e
  puts "#{year}年#{month}月は存在しません。\n西暦を入力してください\n例) ./calender.rb -m 1 -y 2021"
  exit
end

write(year, month)
