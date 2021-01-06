require 'optparse'
opt = OptionParser.new

opt.on('-y', '--year', 'input year')
opt.on('-m', '--month', 'input month')

opt.parse!(ARGV)
year = ARGV[0].to_i
month = ARGV[1].to_i

puts "      " + month.to_s + "月 " + year.to_s
puts "日 月 火 水 木 金 土"

require 'date'
first = Date.new(year, month, 1)
final = Date.new(year, month, -1)

days = []
x = first - 1
while x < final
  x += 1
  # if x.cwday == 6
  #   puts "saturday"
  # end
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
        print "                      " + y.mday.to_s + " "
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
            print y.mday.to_s + " "
          end
        end
      end
    end
  end
end