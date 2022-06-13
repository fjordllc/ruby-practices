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
  (1..Date.new(year, month, -1).day).each do |day|
    date = Date.new(year, month, day)
    date.cwday.times { print "\s" * 3 } if day == 1
    print "\s" if day / 10 == 0
    print "#{ date == Date.today ? "\e[30;47m#{day}\e[0m" : day }"
    print "\s"
    print "\n" if date.saturday?
  end
end

calendar(year, month)
