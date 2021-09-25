require 'optparse'
require 'date'

opt = OptionParser.new

opt = OptionParser.new
opt.on('-y'){|v| p v}
opt.on('-m'){|v| p v}

opt.parse!(ARGV)

year = ARGV[0]
month = ARGV[1]

if month
    print "     #{month}月" 
 else
    print "     #{Date.today.month}月"
    month = Date.today.month
 end
 
 if year
     puts "#{year}"
 else
     puts "  #{Date.today.year}"
     year = Date.today.year
 end

first_date = Date.new(year.to_i,month.to_i,1)
last_date = Date.new(year.to_i,month.to_i,-1)

puts "日 月 火 水 木 金 土"
print "   " * first_date.wday

(first_date..last_date).each do |date|
    if date.wday == 6
        puts date.day.to_s.rjust(2)
    else 
        print date.day.to_s.rjust(2)
        print " "
    end
end
