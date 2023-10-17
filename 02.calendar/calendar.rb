require 'date'

day = Date.today
puts "#{day.strftime("%m月 %Y")}"
puts "日 月 火 水 木 金 土"

last_day = Date.new(day.year, day.month, -1).day
(1..last_day).each do |day|
  print day
end
