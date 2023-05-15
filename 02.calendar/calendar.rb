require 'date'
require 'optparse'

opt = OptionParser.new

options = {}
opt.on('-m MONTH') { |v| options[:month] = v.to_i }
opt.on('-y YEAR') { |v| options[:year] = v.to_i }

opt.parse!(ARGV)

option_year = options[:year] || Date.today.year
option_month = options[:month] || Date.today.month

def date(year = Date.today.year, month = Date.today.month)
    month_frist_day = Date.new(year, month)
    month_last_day = Date.new(year, month, -1)
    year = Date.new(year).year
    month = Date.new(year, month).month
    today =  Date.today
    return month_frist_day, month_last_day, year.to_s, month.to_s, today.day.to_s
end

date = date(option_year,option_month) 
month_frist_day = date[0]
month_last_day = date[1]
year = date[2]
month = date[3]
today = date[4]

puts "      " + month + "月 " + year
puts " 日" + " 月" + " 火" + " 水" + " 木" + " 金" + " 土"
(month_frist_day..month_last_day).each do |date|
    if date.day != 1 && date.sunday? 
        puts "\n"
    end

    if date.day == 1 && date.monday?
        print "   "
    elsif date.day == 1 && date.tuesday?
        print "      "
    elsif date.day == 1 && date.wednesday?
        print "         "
    elsif date.day == 1 && date.thursday?
        print "            "
    elsif date.day == 1 && date.friday?
        print "               "
    elsif date.day == 1 && date.saturday?
        print "                  "
    end

    if date.day == today.to_i
        print " " + "\e[47m\e[30m" + today + "\e[0m"
    elsif date.day.to_s.length == 1 
        print "  " + date.day.to_s
    elsif date.day.to_s.length == 2
        print  " " + date.day.to_s
    end
end

puts "\n"
