require 'date'
require 'optparse'

class Calender
  
  def get_day(i)
    @get_day = Date.new(Time.now.year, Time.now.month, i)
  end

  def create_space(x)
    @space = self.get_day(1).strftime("%e").rjust(x)
  end

  # 月初日の曜日を判定する
  def first_day_search
    if self.get_day(1).monday? then
      print(self.create_space(5))
    elsif self.get_day(1).tuesday? then
      print(self.create_space(8))
    elsif self.get_day(1).wednesday? then
      print(self.create_space(11))
    elsif self.get_day(1).thursday? then
      print(self.create_space(14))
    elsif self.get_day(1).friday? then
      print(self.create_space(17))
    end
  end
end


# 今日を取得
today = Date.today

# 月と年を取得して表示
puts today.strftime("     %-m月 %Y")

# 曜日を表示
week = ["日","月","火","水","木","金","土"]
puts week.join(" ")

cal = Calender.new
start_month = cal.get_day(1).strftime("%e").to_i
end_month = cal.get_day(-1).strftime("%e").to_i

# 日を表示
(start_month..end_month).each do |x|
  day = cal.get_day(x)
  if day.strftime("%e").to_i == start_month then
    print cal.first_day_search
  elsif day.strftime("%e").to_i == end_month || day.saturday? then
    puts day.strftime("%e").rjust(3)
  elsif day.sunday?
    print(day.strftime("%e"))
  else
    print(day.strftime("%e").rjust(3))
  end
end