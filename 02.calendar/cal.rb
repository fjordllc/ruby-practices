require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-y') {|v| v }
opt.on('-m') {|v| v }
opt.parse!(ARGV) 
y =  ARGV[0].to_i
m = ARGV[1].to_i

begin
  dd = Date.new(y,m)
rescue ArgumentError
  dd = Date.new(y = Date.today.year, m = Date.today.month)
end

firstdate = Date.new(y,m,1).wday
lastdate = Date.new(y,m,-1)   
caltitle = "#{dd.month}月 #{dd.year}"
calwday = "日 月 火 水 木 金 土"

puts caltitle.center(20)
puts calwday
print "   " * firstdate
(1..lastdate.day).each do |x|
  print x.to_s.rjust(2) + " "
  firstdate += 1
  if firstdate % 7 == 0
    print "\n"
  end 

#今日の日付の部分の色を反転させようとコードを書いてみたのですが、
#該当の日付の隣に、色が反転した日付が横付けされる表示になってしまいます。
#歓迎要件とのことなので、一旦コメントアウトしてコードを載せておきます。
=begin
  if x == Date.today.day && y == Date.today.year && m == Date.today.month
    print "\e[7m#{x}\e[0m" + " "
  end
=end

end
print "\n"
