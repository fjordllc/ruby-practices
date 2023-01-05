require 'date'

def calender
    today = Date.today

    puts today.strftime('%m月 %Y').center(20)
    puts "\ 日\ 月\ 火\ 水\ 木\ 金\ 土"

end

puts calender
