require 'date'
require 'optparse'

params = ARGV.getopts("y:", "m:") #-y,-mのオプションを登録
y = params["y"].to_i #
m = params["m"].to_i #
#日から土までの曜日の表示(一行に表示)
week = " 日 月 火 水 木 金 土"

if y == 0 && m == 0
  target_day = Date.today
elsif y == 0 && m > 0
  target_day = Date.new(Date.today.year, m)
else
  target_day = Date.new(y, m)
end
#一ヶ月の日数を表示
#today = Date.today #今日の情報(今年、今月、今日)を変数に設定
puts target_day.strftime("%-m月 %Y").center(21) #今月(%-m)と今年(%Y)を中央に表示
puts week #曜日を表示
last_day = Date.new(target_day.year, target_day.month, -1) #今月の最終日を求めるメソッドを変数に設定
last_days = last_day.day #月の最終日を整数オブジェクトにするメソッドを変数に追加
first_day =  Date.new(target_day.year, target_day.month,) #月の最初の日を求めるメソッドを変数に追加
first_wday = first_day.wday #=> 6 #月の最初の日が何曜日かを求めるメソッドを変数に追加(wdayは整数が返ってきる)

first_wday.times do #wdayの戻り値の数だけスペースを繰り返す
  print "   " #スペースは3文字がちょうどいい
end

days = 1..last_days #月の初日と最終日を求め酢メソッドを変数に設定
days.each do |n| #1から最終日までを繰り返し表示
  if Date.new(target_day.year, target_day.month, n).saturday? #.wday == 6でも可 #もしある日が土曜日だったら場合
    puts n.to_s.rjust(3) #改行して(文字列にして)表示
  else
    print n.to_s.rjust(3) #改行せず(文字列にして)表示
  end
end

puts 
