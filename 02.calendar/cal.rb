require 'optparse'
require 'date'

OPTIONS = ARGV.getopts("m:y:")

DATE_TODAY = Date.today
MON  = OPTIONS["m"] ? OPTIONS["m"].to_i : DATE_TODAY.mon
YEAR = OPTIONS["y"] ? OPTIONS["y"].to_i : DATE_TODAY.year

CAL_WIDTH = 20
puts "#{MON}月 #{YEAR}".center(CAL_WIDTH)

LINE_CWDAY = "日 月 火 水 木 金 土"
puts LINE_CWDAY

FIRST_DAY = 1
LAST_DAY = Date.new(YEAR, MON, -1).day
days = (FIRST_DAY..LAST_DAY).to_a.map(&:to_s)

FIRST_CWDAY = Date.new(YEAR, MON).cwday
FIRST_CWDAY.times { days.unshift("\s") }

days = days.map { |day| day.rjust(2) }

LENGTH_A_WEEK = 7
days.each_slice(LENGTH_A_WEEK) { |sliced_days| puts (sliced_days.join("\s")) }
