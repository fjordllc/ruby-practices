require 'date'
require 'optparse'

def calendar(y: Date.today.year, m: Date.today.month, d: Date.today.day)

  firstday = Date.new(y, m, 1)
  lastday = Date.new(y, m, -1)

  head = firstday.strftime("%B %Y").center(20)
  wday = %w(Su Mo Tu We Th Fr Sa).join(' ')
  puts head
  puts wday

  first_wday = firstday.wday

  lastday_date = lastday.day

  days = (1..lastday_date).map { |n| n.to_s.rjust(2) }
  days = Array.new(first_wday, '  ').push(days).flatten.each_slice(7)

  days.each { |week| puts week.join(' ') }
end

def optionparse

  options = {}

  opt = OptionParser.new

  opt.on('-y YEAR') { |v| options[:y] = v.to_i }
  opt.on('-m MONTH') { |v| options[:m] = v.to_i }

  opt.parse!

  options

end

calendar(**optionparse)