require "optparse"
require "date"

options = {
  month: nil,
  year: nil,
}

OptionParser.new do |opts|
  opts.banner = "Usage: calendar.rb [options]"
  
  opts.on("-m", "--month MONTH", "Specify the month") do |month|
    options[:month] = month.to_i
  end
  
  opts.on("-y", "--year YEAR", "Specify the year") do |year|
    options[:year] = year.to_i
  end

  opts.on("-h", "--help", "Display help") do
    puts opts
    exit
  end
end.parse!
  
puts "Month: #{options[:month]}" if options[:month]
puts "Year: #{options[:year]}" if options[:year]
FIRST_DAY_OF_MONTH = 1
LAST_DAY_OF_MONTH = -1

day_of_the_week = Date.new(options[:year], options[:month], FIRST_DAY_OF_MONTH).cwday
days_of_month = Date.new(options[:year], options[:month], LAST_DAY_OF_MONTH).day
  
puts "day_of_the_week #{day_of_the_week}" 
puts "days_of_month #{days_of_month}"

puts "      #{options[:month]}月 #{options[:year]}    "
puts " 日 月 火 水 木 金 土"

print "   " * day_of_the_week

(1..days_of_month).each do |day|
  print "%3d" % day
  puts if (day + day_of_the_week) % 7 == 0
end

puts 
