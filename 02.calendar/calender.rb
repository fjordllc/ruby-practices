require "optparse"
require "date"

def main
  options = parse_options

  month = options[:month]
  year = options[:year]

  print_calendar(month, year) if month && year
end

def parse_options
  options = {
    month: nil,
    year: nil,
  }

  OptionParser.new do |opts|
    opts.banner = "Usage: calendar.rb [options]"

    opts.on("-m", "--month MONTH", "Specify the month") do |month|
      options[:month] = month.to_i
    end

    opts.on("-y", "--year YEAR", "Specify the year") do |year|
      options[:year] = year.to_i
    end

    opts.on("-h", "--help", "Display help") do
      puts opts
      exit
    end
  end.parse!

  options
end

def print_calendar(month, year)
  first_day_of_month = Date.new(year, month, 1).cwday
  last_day_of_month = Date.new(year, month, -1).day

  puts "      #{month}月 #{year}    "
  puts " 日 月 火 水 木 金 土"

  print "   " * first_day_of_month

  (1..last_day_of_month).each do |day|
    print "%3d" % day
    puts if (day + first_day_of_month) % 7 == 0
  end

  puts
end

main
