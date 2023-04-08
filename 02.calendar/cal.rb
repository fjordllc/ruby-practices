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
    puts @year, @month
  end
end

cal = Cal.new
cal.chk_argv
cal.disp
