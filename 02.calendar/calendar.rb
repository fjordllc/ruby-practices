# frozen_string_literal: true

require 'optparse'
require 'date'

def initialize_option_parse
  option = {}

  OptionParser.new do |opts|
    opts.on('-y', '--year YEAR') do |v|
      option[:year] = v.to_i
    end

    opts.on('-m', '--month MONTH') do |v|
      option[:month] = v.to_i
    end
  end.parse!

  option
end

def print_headers(month, year)
  puts "#{month}月 #{year}年".center(25)
  puts '日  月  火  水  木  金  土  '
end

def print_calendar(month: Date.today.month, year: Date.today.year)
  print_headers(month, year)
  date = Date.new(year, month, 1)
  first_wday = date.wday
  print(' ' * 4 * first_wday)
  last_day_of_month = Date.new(year, month, -1)
  (date..last_day_of_month).each do |d|
    print d.mday.to_s.ljust(4)
    puts "\n" if d.saturday?
  end
  puts "\n"
end

print_calendar(**initialize_option_parse)
