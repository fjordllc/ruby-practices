require 'optparse'
require 'date'

options = ARGV.getopts("m:y:")

DATE_TODAY = Date.today
mon  = options["m"] ? options["m"].to_i : DATE_TODAY.mon
year = options["y"] ? options["y"].to_i : DATE_TODAY.year

CAL_WIDTH = 20
puts "#{mon}月 #{year}".center(CAL_WIDTH)

LINE_CWDAY = "日 月 火 水 木 金 土"
puts LINE_CWDAY

last_day = Date.new(year, mon, -1).day
days = (1..last_day).to_a

first_cwday = Date.new(year, mon).cwday
first_cwday.times { days.unshift(" ") }

days = days.map { |num| num.to_s.rjust(2) }

LENGTH_A_WEEK = 7
days.each_slice(LENGTH_A_WEEK) { |day| puts day.join(" ") }
