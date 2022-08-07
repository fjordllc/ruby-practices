#!/usr/bin/env ruby
require 'date'
require 'optparse'

opt = OptionParser.new

opt.on('-y') {|v| v }
opt.on('-m') {|v| v }

argv = opt.parse(ARGV)

if argv[0].to_i == 0
  @month = Date.today.month
else
  @month = argv[0].to_i
end   

if argv[1].to_i == 0
  @year = Date.today.year
else
  @year = argv[1].to_i
end

def first_wday(y = @year, m = @month)
  @first_wday = Date.new(y, m, 1).wday
end
first_wday

def end_date(y = @year, m = @month)
  @end_date = Date.new(y, m, -1).mday
end
end_date

puts "      #{@month}月 #{@year}"
print ["日", "月", "火", "水", "木", "金", "土\n"] * (" ")

# lineは月の1から6週目を表す
def line1
  case @first_wday
  when 0
    print " 1  2  3  4  5  6  7\n"
  when 1
    print "    1  2  3  4  5  6\n"
  when 2
    print "       1  2  3  4  5\n"
  when 3
    print "          1  2  3  4\n"
  when 4
    print "             1  2  3\n"
  when 5
    print "                1  2\n"
  when 6
    print "                   1\n"
  end
end
line1

def line2
  case @first_wday
  when 0
    print " 8  9 10 11 12 13 14\n"
  when 1
    print " 7  8  9 10 11 12 13\n"
  when 2
    print " 6  7  8  9 10 11 12\n"
  when 3
    print " 5  6  7  8  9 10 11\n"
  when 4
    print " 4  5  6  7  8  9 10\n"
  when 5
    print " 3  4  5  6  7  8  9\n"
  when 6
    print " 2  3  4  5  6  7  8\n"  
  end
end
line2

def line3
  case @first_wday
  when 0
    print "15 16 17 18 19 20 21\n"
  when 1
    print "14 15 16 17 18 19 20\n"
  when 2
    print "13 14 15 16 17 18 19\n"
  when 3
    print "12 13 14 15 16 17 18\n"
  when 4
    print "11 12 13 14 15 16 17\n"
  when 5
    print "10 11 12 13 14 15 16\n"
  when 6
    print " 9 10 11 12 13 14 15\n"
  end
end
line3

def line4
  case @first_wday
  when 0
    print "22 23 24 25 26 27 28\n"
  when 1
    print "21 22 23 24 25 26 27\n"
  when 2
    print "20 21 22 23 24 25 26\n"
  when 3
    print "19 20 21 22 23 24 25\n"
  when 4
    print "18 19 20 21 22 23 24\n"
  when 5
    print "17 18 19 20 21 22 23\n"
  when 6
    print "16 17 18 19 20 21 22\n"
  end
end
line4

def line5
  case @first_wday
  when 0
    case @end_date
    when 29
      print "29\n"
    when 30
      print "29 30\n"
    when 31
      print "29 30 31\n"
    end
  when 1
    case @end_date
    when 28
      print "28\n"
    when 29
      print "28 29\n"
    when 30
      print "28 29 30\n"
    when 31
      print "28 29 30 31\n"
    end
  when 2
    case @end_date
    when 28
      print "27 28\n"
    when 29
      print "27 28 29\n"
    when 30
      print "27 28 29 30\n"
    when 31
      print "27 28 29 30 31\n"
    end
  when 3
    case @end_date
    when 28
      print "26 27 28\n"
    when 29
      print "26 27 28 29\n"
    when 30
      print "26 27 28 29 30\n"
    when 31
      print "26 27 28 29 30 31\n"
    end
  when 4
    case @end_date
    when 28
      print "25 26 27 28\n"
    when 29
      print "25 26 27 28 29\n"
    when 30
      print "25 26 27 28 29 30\n"
    when 31
      print "25 26 27 28 29 30 31\n"
    end
  when 5
    case @end_date
    when 28
      print "24 25 26 27 28\n"
    when 29
      print "24 25 26 27 28 29\n"
    when 30
      print "24 25 26 27 28 29 30\n"
    when 31
      print "24 25 26 27 28 29 30\n"
    end
  when 6
    case @end_date
    when 28
      print "23 24 25 26 27 28\n"
    when 29
      print "23 24 25 26 27 28 29\n"
    when 30
      print "23 24 25 26 27 28 29\n"
    when 31
      print "23 24 25 26 27 28 29\n"
    end
  end
end
line5

def line6
  case @first_wday
  when 5
    if @end_date == 31
      print "31\n"
    end
  when 6
    case @end_date
    when 30
      print "30\n"
    when 31
      print "30 31\n"
    end    
  end
end
line6
