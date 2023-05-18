require 'date'
require 'optparse'

options = {}
opt = OptionParser.new
opt.on('-m MONTH') { |v| options[:month] = v.to_i }
opt.on('-y YEAR') { |v| options[:year] = v.to_i }
opt.parse!(ARGV)

today = Date.today
month = options[:month] || today.month
year = options[:year] || today.year
first_date = Date.new(year, month)
last_date = Date.new(year, month, -1)

puts "      #{month}月 #{year}年" 
puts " 日 月 火 水 木 金 土"

print ' ' * (first_day.wday * 3)
  
(first_date..last_date).each do |date|
  if date == today
    print " \e[47m\e[30m#{today.day.to_s.rjust(2)}\e[0m"
  else
    print " #{date.day.to_s.rjust(2)}"
  end 
  if date.saturday?
    print "\n"
  end
end

puts "\n"

