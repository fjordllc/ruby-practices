require 'date'

def calender
    today = Date.today

    puts today.strftime('%m月 %Y').center(20)
    puts "\ 日\ 月\ 火\ 水\ 木\ 金\ 土"

    first_day = Date.new(today.year,today.month,1)
    start_day = first_day.strftime('%d').to_i

    p start_day
end

puts calender
