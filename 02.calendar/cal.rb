require "optparse"
require "date"

params = ARGV.getopts("y:", "m:")

today_date = Date.today

if !params["m"]
  target_month = today_date.month
else
  target_month = params["m"].to_i
end

if !params["y"]
  target_year = today_date.year
else
  target_year = params["y"].to_i
end

puts "       #{target_month}月 #{target_year}"

wdays = [" 日","月","火","水","木","金","土"]
puts wdays.join(" ")

date1 = Date.new(target_year,target_month,1)
blank_count = date1.wday * 3
print " " * blank_count

(Date.new(target_year,target_month,1)..Date.new(target_year,target_month,-1)).each do |date|
  if date.saturday? 
    puts date.day.to_s.rjust(3)
  else 
    print date.day.to_s.rjust(3)
  end
end

