require 'date'
require 'optparse'
require_relative 'cal_month'

def cal
  opt = parse_option

  today = Date.today
  month = if opt.key?(:m)
            opt[:m]
          else
            today.month
          end
  year = if opt.key?(:y)
           opt[:y]
         else
           today.year
         end
  begin
    mon = Month.new(year, month)
  rescue ArgumentError => e
    puts "cal: #{e.message}"
    return
  end

  puts "#{month}月 #{year}".center(20)
  display_day_of_week
  mon.weeks { |week| display_week(week) }
end

def validate_option(opt)
  opt.each do |k, v|
    case k
    when :m
      validate_month(v)
    end
  rescue ArgumentError => e
    raise e
  end
end

def parse_option
  result = {}
  opt = OptionParser.new
  opt.on('-m MONTH', Integer) { |v| result[:m] = v }
  opt.on('-y YEAR', Integer) { |v| result[:y] = v }

  opt.parse!(ARGV)
  result
end

def display_day_of_week
  day_of_week = %w[日 月 火 水 木 金 土]
  sep = ' '
  puts day_of_week.join(sep)
end

def display_week(week)
  displayed_week = week.map { |day| display_day(day) }
  sep = ' '
  puts displayed_week.join(sep)
end

def display_day(day)
  return '  ' if day.nil?

  if day < 10
    " #{day}"
  else
    day.to_s
  end
end

cal
