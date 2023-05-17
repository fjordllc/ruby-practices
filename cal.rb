require 'optparse'
require 'date'

opt = OptionParser.new

opt.on('-y') {|v| v }
opt.on('-m') {|v| v }

opt.parse!(ARGV)

if ARGV == []
    year = Date.today.year
    mon = Date.today.mon
elsif ARGV == ["1"] or ["2"] or ["3"] or ["4"] or ["5"] or ["6"] or ["7"] or ["8"] or ["9"] or ["10"] or ["11"] or ["12"] and ARGV.length == 1
    year = Date.today.year
    mon = ARGV[0].to_i
else
    year = ARGV[0].to_i
    mon = ARGV[1].to_i
end

header = Date.new(year,mon).strftime("%m月 %Y")

fday = Date.new(year,mon,1).wday
lday = Date.new(year,mon,-1).day
week = ['日 ' '月 ' '火 ' '水 ' '木 ' '金 ' '土 ']

puts header.center(20)
puts week
print "   " * fday

wday = fday
(1..lday).each do |date|
  print date.to_s.rjust(2) + " "
  wday = wday + 1
  if wday%7==0
    print "\n"
  end
end
if wday%7!=0
    print "\n"
end