require 'date'
require 'optparse'

class Calendar
  def show_calendar(date = Date.today)
    puts [
      date.strftime("%-m月 %Y").center(20),
      '日 月 火 水 木 金 土',
      format_days_of_month(date).each_slice(7).map { |slice| slice.join(' ') },
      ''
    ].join("\n")
  end

  def format_days_of_month(date)
    days_in_month = Date.new(date.year, date.month, -1).day
    first_day_day_of_week = Date.new(date.year, date.month, 1).wday

    padding = Array.new(first_day_day_of_week, '')
    month_with_padding = padding + (1..days_in_month).to_a
    month_with_padding.map do |day|
      day.to_s.rjust(2)
    end
  end

end

options = ARGV.getopts('m:', 'y:')
if options['m'].nil? and options['y'].nil?
  Calendar.new.show_calendar(Date.today)
else
  Calendar.new.show_calendar(Date::strptime(options['y']+"-"+options['m']+"-1", "%Y-%m-%d"))
end