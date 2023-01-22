require 'date'
require 'optparse'

params = OptionParser.new
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

year = params.values[0].to_i
month = params.values[1].to_i

first_date = Date.new(year, month, 1).wday
end_date = Date.new(year, month, -1).day

puts (month.to_s + "月" + " " + year.to_s + "年").center(21) 
puts "\n"
puts '日 月 火 水 木 金 土'
space = "   " * first_date
print space

(1..end_date).each do |x|
    if (first_date + x) % 7 == 0
        print x.to_s.rjust(2) + "\n"
    else
        print x.to_s.rjust(2) + " "
    end
end
print "\n"


