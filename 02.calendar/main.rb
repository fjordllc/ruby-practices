require 'date'

# year と month を受け取る
DAY = %w[日 月 火 水 木 金 土]

year = Date.today.year
month = Date.today.month
cwday = Date.new(year, month, 1).cwday
last_date = Date.new(year, month, -1).day

week = []
start_date = 1
week_count = 0

# 1週間分を作るための for
(start_date..last_date).each do|day|
  if day == 1 && cwday != 7
    cwday.times do
      week << " "
      week_count += 1
    end
  end
  week << day
  week_count += 1
  if week_count == 7
    puts week.to_s
    week_count = 0
    week = []
  end
end
