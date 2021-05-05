# #!/usr/bin/env ruby
# require 'date'
#
# today_day = Date.today
# today_month = today_day.month.to_i
# today_year = today_day.year.to_i
# # p today_month
# # p today_year
#
# first_day = Date.new(today_year, today_month, 1)
# last_day = Date.new(today_year, today_month, -1)
#
# day_of_week = %w[日 月 火 水 木 金 土]
# day_of_week.each do |x|
#   print x
#   print ' '
# end
# puts "\n"
#
# print "\s" * 3 if first_day.monday?
# print "\s" * 6 if first_day.tuesday?
# print "\s" * 9 if first_day.wednesday?
# print "\s" * 12 if first_day.thursday?
# print "\s" * 15 if first_day.friday?
# print "\s" * 18 if first_day.saturday?
#
# (first_day..last_day).each do |everyday|
#   print everyday.strftime('%e')
#   print ' '
#   if everyday.saturday?
#     print "\n"
#     format('%s', everyday)
#   end
# end
# puts "\n"

#!/usr/bin/env ruby
require 'optparse'
require 'date'

options = ARGV.getopts("", "m:#{Date.today.month}", "y:#{Date.today.year}")

today_m = options['m'].to_i
today_y = options['y'].to_i

puts ("#{today_m}月"+ " " + "#{today_y}").center(20)

first_day = Date.new(today_y, today_m, 1)
last_day = Date.new(today_y, today_m, -1)

day_of_week = %w[日 月 火 水 木 金 土]
day_of_week.each do |d|
  print d
  print ' '
end
puts "\n"

print "\s" * 3 if first_day.monday?
print "\s" * 6 if first_day.tuesday?
print "\s" * 9 if first_day.wednesday?
print "\s" * 12 if first_day.thursday?
print "\s" * 15 if first_day.friday?
print "\s" * 18 if first_day.saturday?

(first_day..last_day).each do |everyday|
  print everyday.strftime('%e')
  print ' '
  if everyday.saturday?
    print "\n"
    format('%s', everyday)
  end
end
puts "\n"

