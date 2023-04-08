require "optparse"
require "date"

class Cal
  def initialize
    @year = Date.today.year
    @month = Date.today.month
  end

  def usage
    puts "cal.rb [-m month] [-y year]"
    puts "-m: month (1-12)"
    puts "  ex) -m 12"
    puts "-y: year (1970-2100) (This option also need month option)"
    puts "  ex) -y 2023 -m 12"
  end

  def usage_exit
    usage
    exit false
  end

  def chk_argv
    begin
      options = ARGV.getopts('y:', 'm:')
    rescue OptionParser::MissingArgument
      usage_exit
    end
    usage_exit if options["y"] && options["m"].nil?
    if options["y"]
      year = options["y"].to_i
      usage_exit if year < 1970 || year > 2100
      @year = year
    end
    if options["m"]
      month = options["m"].to_i
      usage_exit if month < 1 || month > 12
      @month = month
    end
  end

  def disp
    charnum_of_week = ("11 " * 7).length - 1
    day_of_week_str = "日 月 火 水 木 金 土"
    puts "#{@month}月 #{@year}".center(charnum_of_week)
    firstday = Date.new(@year,@month,1)
    lastday = Date.new(@year,@month,-1)
    first_days_day_of_week = firstday.wday
    puts day_of_week_str
    day_num = 0
    weekstr = ""
    lastday.day.times.each do |i|
      day_num = i + 1
      day = Date.new(@year,@month,day_num)
      if day.saturday?
        weekstr += day_num.to_s.rjust(2)
        puts weekstr.rjust(charnum_of_week)
        weekstr = ""
      elsif day == lastday
        weekstr += day_num.to_s
        puts weekstr
        weekstr = ""
      else
        weekstr += day_num.to_s.rjust(2) + " "
      end
    end
  end
end

cal = Cal.new
cal.chk_argv
cal.disp
