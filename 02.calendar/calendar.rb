require 'optparse'
require 'date'

def calendar(year, month)
  puts "      #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"
  (Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
    day = date.day.to_s.rjust(2)
    date.cwday.times { print "\s" * 3 } if day == 1 && !date.sunday?
    print date == Date.today ? "\e[30;47m#{day}\e[0m" : day
    print "\s" unless date.saturday?
    print "\n" if date.saturday?
  end
end

options = ARGV.getopts('y:', 'm:')
year = options['y'] || Date.today.year
month = options['m'] || Date.today.month

calendar(year.to_i, month.to_i)
