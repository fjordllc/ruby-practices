require 'date'
require 'optparse'

params = ARGV.getopts("", "m:#{Date.today.month}", "y:#{Date.today.year}")
month_and_year = params.transform_values(&:to_i)

def validate_month(month)
  return true if (1..12).include?(month)

  puts "月は1から12月までを入力してください"
  false
end

def validate_year(year)
  return true if year >= 1970

  puts "年は1970年以降を入力してください"
  false
end

def validate_option_argument(month_and_year)
  exit if !validate_month(month_and_year["m"]) ||
          !validate_year(month_and_year["y"])
end

def create_all_days_array(month, year)
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  all_days = (first_day..last_day)
  all_days_array = []

  first_day.wday.times {all_days_array.unshift " "}
  all_days.each do |day| 
    all_days_array.push day.day.to_s
    all_days_array.push "\n" if day.wday == 6
  end

  all_days_array
end

def calender(month_and_year)
    month = month_and_year["m"]
    year = month_and_year["y"]

    puts "#{month}月 #{year}".center(7 * 3)
    puts " 日 月 火 水 木 金 土"
    all_days = create_all_days_array(month, year)
    all_days.each {|day| print day.rjust(3)}
end

validate_option_argument(month_and_year)
calender(month_and_year)
