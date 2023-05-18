require 'date'
require 'optparse'

options = {}
opt = OptionParser.new
opt.on('-m MONTH') { |v| options[:month] = v.to_i }
opt.on('-y YEAR') { |v| options[:year] = v.to_i }
opt.parse!(ARGV)

year = options[:year] || Date.today.year
month = options[:month] || Date.today.month
today = Date.today
first_day = Date.new(year, month)
last_day = Date.new(year, month, -1)

puts "      #{month}月 #{year}年" 
puts " 日 月 火 水 木 金 土"

print ' ' * (first_day.wday * 3)
  
(first_day..last_day).each do |day|
  if day == today
    print " \e[47m\e[30m#{today.day.to_s.rjust(2)}\e[0m"
  else
    print " #{day.day.to_s.rjust(2)}"
  end 
  if day.saturday?
    print "\n"
  end
end

puts "\n"
