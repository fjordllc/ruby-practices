require 'optparse'
require 'date'

opt = OptionParser.new

opt.on('-m'){|v| p v}
opt.on('-y'){|v| p v}

opt.parse!(ARGV)

if ARGV[1]
   print "     #{ARGV[1]}月"
else
   ARGV[1] = Date.today.month
   print "     #{ARGV[1]}月"
end

if ARGV[0]
   puts "  #{ARGV[0]}"
else
   ARGV[0] = Date.today.year
   puts "  #{ARGV[0]}"
end

first_date = Date.new(ARGV[0].to_i,ARGV[1].to_i,1)
last_date = Date.new(ARGV[0].to_i,ARGV[1].to_i,-1)

puts "日 月 火 水 木 金 土"
print "   " * first_date.wday

(first_date..last_date).each do |date|
    print date.day.to_s.rjust(2)
    print ' '
    if date.wday == 6
      puts ''
    end
end
