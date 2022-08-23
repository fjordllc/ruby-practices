require 'optparse'
require 'date'

opt = OptionParser.new

# オプションとその引数
# インスタンス変数でブロック外でも値が使えるようになっている
opt.on('-year YEAR'){|y| @y = y }
opt.on('-month MONTH'){|m| @m = m }
opt.parse!(ARGV)

# 年や月が指定されなかった場合、今の年・月を表示する
@y = Date.today.year if @y.nil?
@m = Date.today.month if @m.nil?

# 例外の処理
if @y.to_i < 1 || ( @m.to_i > 12 || @m.to_i < 1 )
  puts "正しい数値を入力してください"
  return
end

# 年月の表示
puts "      #{@m}月 #{@y}"

# 曜日の表示
puts "日 月 火 水 木 金 土"

# 日付の表示
first_date = Date.new(@y.to_i, @m.to_i, 1)
last_date = Date.new(@y.to_i, @m.to_i, -1)
first_date.wday.times { print "   " } # 先月分の空白
(first_date..last_date).each do |date|
  if date == Date.today # 今日の日付の部分の色を反転させる
    print "\e[7m#{date.day}\e[0m".rjust(2) + " "
  else
    print date.day.to_s.rjust(2) + " "
  end
  if date.wday == 6 # 土曜日で改行する
    print "\n"
  end
end
print "\n"

