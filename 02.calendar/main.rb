require_relative 'cls/option'
require_relative 'cls/calendar'

month = 'm'
year = 'y'
opt = Option.new(month, year)
Calendar.new(opt.options[month], opt.options[year])
