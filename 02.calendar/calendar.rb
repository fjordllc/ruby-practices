require 'optparse'
require 'date'

opt = OptionParser.new

# オプションとその引数
# インスタンス変数でブロック外でも値が使えるようになっている
opt.on('-year YEAR'){|y| @y = y }
opt.on('-month MONTH'){|m| @m = m }
opt.parse!(ARGV)

# 年や月が指定されなかった場合、今の年・月を表示する
if @y == nil && @m == nil
  @y = Date.today.year
	@m = Date.today.month
elsif @y == nil
	@y = Date.today.year
elsif @m == nil
	@m = Date.today.month
end

# 例外の処理
if @y =~ /[a-zA-Z]/ || @m =~ /[a-zA-Z]/
	puts "数値を入力してください"
  return
elsif @y.to_i < 1 || @m.to_i < 1
  puts "数値がマイナス、もしくは小数点以下です"
  return
elsif @m.to_i > 12
  puts "月の数字が大きすぎます"
  return
end

# 年月の表示
puts "      " + @m.to_s + "月" + " " + @y.to_s

# 曜日の表示
puts "日 月 火 水 木 金 土"

# 日付の表示
first_date = Date.new(@y.to_i, @m.to_i, 1)
last_date = Date.new(@y.to_i, @m.to_i, -1)
(first_date.cwday.to_i % 7).times { |n| print "   "} # 先月分の空白
(first_date.day - 1..last_date.day - 1).each { |day|
  day += 1
  if Date.new(@y.to_i, @m.to_i, day) == Date.today && day.to_i < 10 # 今日の日付の部分の色を反転させる
		print " " + "\e[7m#{day}\e[0m" + " "
  elsif Date.new(@y.to_i, @m.to_i, day) == Date.today && day.to_i >= 10
		print "\e[7m#{day}\e[0m" + " "
	elsif day.to_i < 10
	  print " " + day.to_s + " "
	else
		print day.to_s + " "
	end

  if day.to_i % 7 == (first_date.cwday.to_i - 7).abs # 土曜日で改行する
    print "\n"
  end
	}
	print "\n"

