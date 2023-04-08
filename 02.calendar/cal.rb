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
    i = 0
    chk_val_flag = false
    ARGV.each do |argv|
      unless chk_val_flag # check option flag
        case argv
        when "-y", "-m"
          chk_val_flag = true
        else
          usage_exit
        end
      else # check option value
        chk_val_flag = false
        case ARGV[i-1]
        when "-y"
          usage_exit unless ARGV.include?("-m")
          tmp_year = argv.to_i
          usage_exit unless tmp_year >= 1970 && tmp_year <= 2100
          @year = tmp_year
        when "-m"
          tmp_month = argv.to_i
          usage_exit unless tmp_month >= 1 && tmp_month <= 12
          @month = tmp_month
        end
      end
      i += 1
    end
    if chk_val_flag
      usage_exit
    end
  end

  def disp
    puts @year, @month
  end
end

cal = Cal.new
cal.chk_argv
cal.disp
