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

    def print_headers month, year
      puts "\t #{month}月 #{year}年"
      puts "日  月  火  水  木  金  土  "
    end

    def days_in_month month, year
      days = 0
      case month
      when 1
        days = 31
      when 2
        if(year % 4 != 0)
          days = 28
        else
          days = 29
        end
      when 3
        days = 31
      when 4
        days = 30
      when 5
        days = 31
      when 6
        days = 30
      when 7
        days = 31
      when 8
        days = 31
      when 9
        days = 30
      when 10
        days = 31
      when 11
        days = 30
      when 12
        days = 31
      end
    end

    def spacing_before_first_day_of_month first_day
      i = 0
      while i < first_day
        print "    "
        i = i + 1
      end
    end

    def weekday_for_given_date date, month, year
      #サカモトのアルゴリズム (https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week)
      offset = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
      year = year - 1 if month < 3
      (year + year / 4 - year / 100 + year / 400 + offset[month - 1] + date) % 7
    end

    def print_calendar(month: Date.today.month, year: Date.today.year)
      print_headers(month, year)
      if(month <= 12 && month >= 1)
        first_day = weekday_for_given_date 1, month, year
        spacing_before_first_day_of_month(first_day)
        day = 1
        while day <= days_in_month(month, year)
          if day < 10
            print "#{day}   "
          else
            print "#{day}  "
          end
          if((first_day + day) % 7 == 0)
            puts "\n"
          end
          day += 1
        end
      end
      puts "\n"
    end
end

calendar = Calendar.new
calendar.print_calendar(**calendar.init_option_parse)
