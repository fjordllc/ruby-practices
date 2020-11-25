#-m（オプション）〜 を指定した時にプログラムに渡される仕組みを扱えるようにする。
  #オプションを定義するとどのような結果になるか調べる。
  #カレンダープログラミングではどのようにオプションを活用できるのか模索する。

#受け取った年月の最終日に変動あるのをどう判断するか。
  #最終日は３０日なのか３１日なのか
  #dateクラスの使い方とどのような事ができるか調べる。
  #なんの条件判断のプログラミングをしたら正確な日数が表示されるのか

#指定した月の１日が何曜日から始まっているか。

#隙間を何個空けるか算出する。（○曜日だったら何個とか）
#１行に７日ずつ改行できるようにする。(eachメソッドを使う)

require "date"

wdays = ["日", "月", "火", "水", "木" ,"金", "土"]

if ARGV[0] == "-m"
  month = ARGV[1]
  year = ARGV[3]
elsif ARGV[0] == "-y"
  year = ARGV[1]
  month = ARGV[3]
end

date = Date.new(year.to_i, month.to_i, -1)
first_day = Date.new(year.to_i, month.to_i)

print "    " + month + "月"
print year + "年"
print "\n"

 wdays.each do |week|
  print week + " "
 end
 print "\n"

 blanks = [" "] * first_day.wday
 blanks.concat((1..date.mday).map(&:to_s)).each_slice(7).to_a.each do |days|
  days.each do |day|
   print day.length > 1 ? day + " " : " " + day + " "
  end
  print "\n"
 end

# 今月のカレンダーを表示するプログラムを書いてみよう。（コマンドラインのプログラムとして作ろう）
# macに入っているcalコマンドと同じ見た目にしよう。（今日の日付の部分の色が反転してるところはやらなくてもいいです。）
# また、-mで月を、-yで年を指定できるようにしよう。（指定しない場合は今月・今年）
# 少なくとも1970年から2100年までは表示できること。

#今回はdate→Dateクラス自身をRubyのコード上に引っ張ってくる必要があります。
# この【必要なものを外からとってくる】ために使われるのが【require】メソッドです。
#printメソッド→改行

# 1日の曜日によって空白の数が変わる