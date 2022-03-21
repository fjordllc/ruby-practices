
require  'Date'

#今日の日付を生成する
today = Date.today

#今日の日付から西暦/月を出力する
year = today.year
month = today.month

#今月の開始曜日を調べる
dweek = Date.new(year,month,1).wday

#最終日を基準に日付の配列を作成する
last_day = Date.new(year,month,-1).day
day_array = [*1..last_day]

#開始曜日毎に配列に空欄を追加する
dweek.times do
  day_array.unshift(" ")
end

#今月が何週かを確認する
weeks_count = day_array.length / 7
weeks_count += 1 if day_array.length % 7 > 0

#カレンダータイトルの作成
calender_title = Date.new(year,month,1).strftime("%-m月 %Y")
calender_head = %w[日 月 火 水 木 金 土]

#カレンダーの出力
puts calender_title.center(21," ")
puts " " + calender_head.join(" ")

#ある週分timesを回す
weeks_count.times do
  #1週分の内容weekにセットする
  week = day_array.shift(7)

  #nilの場合の対処として、空欄を入れる
  if week[6] == nil
    week.map {|e| e ? e : " " }
  end

  #1週分を出力する
  printf("%3s%3s%3s%3s%3s%3s%3s\n",
         week[0],week[1],week[2],week[3],week[4],week[5],week[6])
end
