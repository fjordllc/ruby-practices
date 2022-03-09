require 'date'

# 対象月の最終日の取得
endof_month = Date.new(2022, 4, -1)

# 対象月の各日付のオブジェクトを格納したEnumeratorオブジェクトの作成
cal = Enumerator.new { |y|
  endof_month.mday.times do |i|
    y << Date.new(2022, 4, i + 1)
  end
}

# 見出し年月の表示
puts "#{endof_month.month}月 #{endof_month.year}".center(28)

# # 見出し曜日の表示
week = ["日", "月", "火", "水", "木", "金", "土"]
week.each_index do |i|
  print " #{week[i]} "
  # 土曜日で改行
  puts "\n" if i == 6
end

# 日付表示
cal.each do |d|
  # 1日が日曜日以外の時に先頭に空白を入れる処理
  if d.wday != 0 && d.mday == 1
    print "    " * d.wday
    print "  #{d.mday} "
  # 日付が一桁の時の空白調整
  elsif d.mday < 10
    print "  #{d.mday} "
  else
    print " #{d.mday} "
  end
  # 曜日が土曜日の時の改行
  print "\n" if d.wday == 6
end