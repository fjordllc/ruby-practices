# frozen_string_literal: true

require 'optparse'
require 'date'

class Calendar
  def init_option_parse
    options = {}

    OptionParser.new do |opts|
      opts.on('-y', '--year YEAR') do |v|
        options[:year] = v.to_i
      end

      opts.on('-m', '--month MONTH') do |v|
        options[:month] = v.to_i
      end
    end.parse!

    options
  end

  def print_headers(month, year)
    puts "\t #{month}月 #{year}年"
    puts '日  月  火  水  木  金  土  '
  end

  def days_in_month(month, year)
    case month
    when 2
      if year % 4 != 0
        28
      else
        29
      end
    when 1, 3, 5, 7, 8, 10, 12
      31
    when 4, 6, 9, 11
      30
    end
  end

  def spacing_before_first_day_of_month(first_day)
    i = 0
    while i < first_day
      print '    '
      i += 1
    end
  end

  def weekday_for_given_date(date, month, year)
    # サカモトのアルゴリズム (https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week)
    offset = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
    year -= 1 if month < 3
    (year + year / 4 - year / 100 + year / 400 + offset[month - 1] + date) % 7
  end

  def print_calendar(month: Date.today.month, year: Date.today.year)
    if month <= 12 && month >= 1
      print_headers(month, year)
      first_day = weekday_for_given_date 1, month, year
      spacing_before_first_day_of_month(first_day)
      day = 1
      while day <= days_in_month(month, year)
        if day < 10
          print "#{day}   "
        else
          print "#{day}  "
        end
        puts "\n" if ((first_day + day) % 7).zero?
        day += 1
      end
    end
    puts "\n"
  end
end

calendar = Calendar.new
calendar.print_calendar(**calendar.init_option_parse)
