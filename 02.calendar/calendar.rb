require 'date'
require 'optparse'

opt = OptionParser.new

options = {}
opt.on('-m MONTH') { |v| options[:month] = v.to_i }
opt.on('-y YEAR') { |v| options[:year] = v.to_i }

opt.parse!(ARGV)

option_year = options[:year] || Date.today.year
option_month = options[:month] || Date.today.month

month_first_day = Date.new(option_year, option_month)
month_last_day = Date.new(option_year, option_month, -1)
year = Date.new(option_year).year
month = Date.new(option_year, option_month).month
today = Date.today
  
puts "      #{month}月 #{year}" 
puts " 日 月 火 水 木 金 土"

(month_first_day..month_last_day).each do |date|
  for i in 1..6
    if date.day == 1 && date.wday == i
      print ' ' * i * 3
    end
  end 
  if date.day == today.day
    print " \e[47m\e[30m#{today.day.to_s.rjust(2)}\e[0m"
  else
    print " #{date.day.to_s.rjust(2)}"
  end 
  if date.saturday?
    print "\n"
  end
end

puts "\n"
   