require 'optparse'
require 'date'

def calendar(year, month)
  puts "      #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"
  (Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
    day = date.day
    date.cwday.times { print "\s" * 3 } if day == 1
    print "\s" if day / 10 == 0
    print "#{ date == Date.today ? "\e[30;47m#{day}\e[0m" : day }"
    print "\s"
    print "\n" if date.saturday?
  end
end

options = ARGV.getopts('y:', 'm:')
year = options['y']
year ||= Date.today.year
month = options['m']
month ||= Date.today.month

calendar(year.to_i, month.to_i)
