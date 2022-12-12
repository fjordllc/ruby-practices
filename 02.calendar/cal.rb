require "optparse"
require "date"

params = ARGV.getopts("y:", "m:")

today_date = Date.today

target_month =
  if params["m"]
    params["m"].to_i
  else
    today_date.month
  end

target_year = 
  if params["y"]
    params["y"].to_i
  else
    today_date.year
  end

puts "       #{target_month}月 #{target_year}"

wdays = [" 日","月","火","水","木","金","土"]
puts wdays.join(" ")

first_date_of_month = Date.new(target_year,target_month,1)
blank_count = first_date_of_month.wday * 3
print " " * blank_count

(Date.new(target_year,target_month,1)..Date.new(target_year,target_month,-1)).each do |date|
  if date.saturday? 
    puts date.day.to_s.rjust(3)
  else 
    print date.day.to_s.rjust(3)
  end
end

