require 'date'
day = Date.today
year = day.year
month = day.month
today = day.day
require 'optparse'
opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }
opt.parse!(ARGV)
# 読み込んで、使いやすくする
# まずはopt.parse!(ARGV)を読み込まないと3〜４行目は動かない。
# p ARGV
# ARGVはただ入れた情報を読み込んでそのままarrayとして入れているだけのもの。opt.parse!で動くようになる。
puts "\x1B[36;1m#{month}\x1B[37;m月\x1B[36;1m#{year}\x1B[37;m".rjust(38)
# puts "\x1B[36;1m#{year}\x1B[37;m"
puts "日 月 火 水 木 金 土"
end_of_date = Date.new(year, month, -1).day
#-1は一番最後の日にち取得
start_of_date = Date.new(year, month, 1).wday
#曜日の番号を習得するにはwdayを使う！
#最初の日にちの曜日番号の取得
youbi = 0
while youbi < start_of_date
    youbi += 1
    if youbi == 1
      print " ".rjust(2)
    else
      print " ".rjust(3)
    end
end
#youbi = 3
num = 0
while num < end_of_date do
  num += 1
  case 
  when num == today
    print "\x1B[31;1m#{num}\x1B[37;m".rjust(15)
  when (youbi)%7 == 0 && num < 10
    print "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
  #曜日が０かつ、数字が１０未満だったら
  when (youbi)%7 == 0 
    print "\x1B[36;1m#{num}\x1B[37;m"
  #曜日が０だったら
  else 
    print " " + "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
  end
  if ((youbi+=1)%7 == 0)
      #曜日は0〜６までなので、numにプラス１することで、７の倍数が作れる。
    puts
  end
end
#始まりは、その前のwhileのコードで最後のyoubiの数字が3なので、その情報が最後のwhileで引き継がれている。