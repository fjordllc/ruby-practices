require 'optparse'
require 'date'

opt = OptionParser.new

opt.on('-m'){|v| p v}
opt.on('-y'){|v| p v}

opt.parse!(ARGV)

month = ARGV[1]
year = ARGV[0]

if month
   print "     #{month}月"
else
   month = Date.today.month
   print "     #{month}月"
end

if year
   puts "  #{year}"
else
   year = Date.today.year
   puts "  #{year}"
end

first_date = Date.new(year.to_i,month.to_i,1)
last_date = Date.new(year.to_i,month.to_i,-1)

puts "日 月 火 水 木 金 土"
print "   " * first_date.wday

(first_date..last_date).each do |date|
   print date.day.to_s.rjust(2)
   print ' '
   if date.wday == 6
      puts ''
   end
end

