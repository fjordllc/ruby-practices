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

# monday = []
# tuesday = [
# wednesday = []
# thursday = []
# friday = []
# saturday = []
# sunday = []

# (month_frist..month_last).each do |i|
#     if i.monday?
#         monday.push(i)
#     elsif i.tuesday?
#         tuesday.push(i)
#     elsif i.wednesday?
#         wednesday.push(i)
#     elsif i.thursday?
#         thursday.push(i)
#     elsif i.friday?
#         friday.push(i)
#     elsif i.saturday?
#         saturday.push(i)
#     elsif i.sunday?
#         sunday.push(i)
#     end
# end

# def day_of_the_week(day_of_the_week)
#     day_of_the_week.each do |i|
#         day = i.day.to_s
#         if day.length == 1
#             puts " " + day
#         elsif day.length == 2
#             puts day
#         end
#     end
# end

# puts "      " + month + "月 " + year
# puts " 日"
# day_of_the_week(sunday)
# puts " 月"
# day_of_the_week(monday)
# puts " 火"
# day_of_the_week(tuesday)
# puts " 水"
# day_of_the_week(wednesday)
# puts " 木"
# day_of_the_week(thursday)
# puts " 金"
# day_of_the_week(friday)
# puts " 土"
# day_of_the_week(saturday)