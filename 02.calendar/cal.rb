require 'date'
require 'optparse'
require_relative 'one_month'

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
    one_month = OneMonth.new(year, month)
  rescue ArgumentError => e
    puts "cal: #{e.message}"
    return
  end

  draw_year_and_month(year, month)
  draw_day_of_week
  draw_weeks(one_month)
end

def parse_option
  result = {}
  opt = OptionParser.new
  opt.on('-m MONTH', Integer) { |v| result[:m] = v }
  opt.on('-y YEAR', Integer) { |v| result[:y] = v }

  opt.parse!(ARGV)
  result
end

def draw_year_and_month(year, month)
  puts "#{month}月 #{year}".center(20)
end

def draw_day_of_week
  displayed_day_of_week = %w[日 月 火 水 木 金 土]
  sep = ' '
  puts displayed_day_of_week.join(sep)
end

def draw_weeks(month)
  month.weeks { |week| draw_week(week) }
end

def draw_week(week)
  displayed_week = week.map { |day| displayed_day(day) }
  sep = ' '
  puts displayed_week.join(sep)
end

def displayed_day(day)
  return '  ' if day.nil?

  if day < 10
    " #{day}"
  else
    day.to_s
  end
end

cal
