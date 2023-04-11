require "optparse"
require "date"

year = Time.now.year #=> 今年を取得
month = Time.now.month #=> 今月を取得

option = {} #=> ハッシュを用意
opt = OptionParser.new #=> ハッシュを生成
opt.on('-y VAL', Integer, '年を入力しください（数字のみ）') {|v| option[:y] = v } #=> keyをyに、valueを数字のみ
opt.on('-m VAL', Integer, '月を入力しください（数字のみ）') {|v| option[:m] = v } #=> keyをyに、valueを数字のみ
opt.parse(ARGV) #=> コマンドラインで解析する
# ----------------------------------------------------
if option[:y] && option[:m]
  first_day = Date.new(option[:y], option[:m], 1)
  last_day = Date.new(option[:y], option[:m], -1)
  puts "#{option[:m]}月 #{option[:y]}".center(20) # => 年月日を表示
elsif option[:m]
  first_day = Date.new(year, option[:m], 1)
  last_day = Date.new(year, option[:m], -1)
  puts "#{option[:m]}月 #{year}".center(20) # => 年月日を表示
else
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  puts "#{month}月 #{year}".center(20) # => 年月日を表示
end
week_day = ["日","月","火","水","木","金","土"]


puts week_day.join(' ').center(16) # => 曜日を表示

week_number = first_day.wday # => 初日の曜日を数値で返す
space = "   " * week_number # => ↑返された数値にスペースを掛ける
print space

betWeen_days = first_day.day..last_day.day
betWeen_days.each do |day|
  print day.to_s.rjust(3)
  
  if week_number == 0 && day % 7 == 0
    print "\n"
  elsif week_number == 1 && day % 7 == 6
    print "\n"
  elsif week_number == 2 && day % 7 == 5
    print "\n"
  elsif week_number == 3 && day % 7 == 4
    print "\n"
  elsif week_number == 4 && day % 7 == 3
    print "\n"
  elsif week_number == 5 && day % 7 == 2
    print "\n"
  elsif week_number == 6 && day % 7 == 1
    print "\n"
  end
end
puts "\n"

