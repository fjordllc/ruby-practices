require 'optparse'
require 'date'

options = ARGV.getopts('y:', 'm:')

year = options['y']
year ||= Date.today.year

month = options['m']
month ||= Date.today.month

def calendar(year, month)
  year = year.to_i
  month = month.to_i
  puts "      #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"
  last_day_of_the_month = Date.new(year, month, -1).day
  (1..last_day_of_the_month).each do |day|
    date = Date.new(year, month, day)
    if day == 1
      date.cwday.times do
        print "\s" * 3
      end
    end
    if day / 10 == 0
      print "\s"
    end
    if date == Date.today
      print "\e[30;47m#{day}\e[0m"
    else
      print day
    end
    print "\s"
    if date.saturday?
      print "\n"
    end
  end
end

calendar(year, month)
