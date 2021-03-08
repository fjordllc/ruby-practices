require 'date'

# 月と年を取得して表示
today = Date.today
puts today.strftime("     %-m月 %Y")

# 曜日を表示
week = ["日","月","火","水","木","金","土"]
puts week.join(" ")
# 日を表示
start_day = Date.new(today.year, today.month, 1).strftime("%e").to_i
end_day = Date.new(today.year, today.month, -1).strftime("%e").to_i

(start_day..end_day).each do |x|
  day = Date.new(today.year, today.month, x)

  if day.strftime("%e").to_i == start_day then
    if day.monday? then
      print(day.strftime("%e").rjust(5))
    elsif day.tuesday? then
      print(day.strftime("%e").rjust(8))
    elsif day.wednesday? then
      print(day.strftime("%e").rjust(11))
    elsif day.thursday? then
      print(day.strftime("%e").rjust(14))
    elsif day.friday? then
      print(day.strftime("%e").rjust(17))
    end
  elsif day.strftime("%e").to_i == end_day then
    puts day.strftime("%e").rjust(3)
  elsif day.sunday?
    print(day.strftime("%e"))
  elsif day.saturday?
    puts day.strftime("%e").rjust(3)
  else
    print(day.strftime("%e").rjust(3))
  end
end