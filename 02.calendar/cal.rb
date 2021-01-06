require 'optparse'
require 'date'

options = ARGV.getopts('y:', 'm:')

if options["y"].nil?
  year = Date.today.year.to_i
else
  year = options["y"].to_i
end
if options["m"].nil?
  month = Date.today.mon.to_i
else
  month = options["m"].to_i
end

puts "      " + month.to_s + "月 " + year.to_s
puts "日 月 火 水 木 金 土"

first = Date.new(year, month, 1)
final = Date.new(year, month, -1)

days = []
x = first - 1
while x < final
  x += 1
  days.push(x)
end

days.each do |y|
  if y.mday == 1 && y.cwday == 6
    print "                   " + y.mday.to_s + "\n"
  else
    if y.mday == 1
      case y.cwday
      when 1
        print "    " + y.mday.to_s + " "
      when 2
        print "       " + y.mday.to_s + " "
      when 3
        print "          " + y.mday.to_s + " "
      when 4
        print "             " + y.mday.to_s + " "
      when 5
        print "                " + y.mday.to_s + " "
      when 7
        print " " + y.mday.to_s + " "
      end
    else
      if y.cwday == 6 && y.mday < 10
        print " " + y.mday.to_s + "\n"
      else
        if y.cwday == 6
          print y.mday.to_s + "\n"
        else
          if y.mday < 10
            print " " + y.mday.to_s + " "
          else
            if y == final
              print y.mday.to_s + "\n"
            else
              print y.mday.to_s + " "
            end
          end
        end
      end
    end
  end
end