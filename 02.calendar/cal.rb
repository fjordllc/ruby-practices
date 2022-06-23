require 'date'
require 'optparse'

LINE_LENGTH = 20

def cal
  # 引数を受け付ける
  params = ARGV.getopts("y:m:")

  # 年月の設定
  # 引数のしていたなかったら、現在月
  if params["y"] == nil && params["m"] == nil
    date = Date.today
  # -y -mどちらの引数もあったら、引数で指定された年月
  elsif year?(params["y"]) && month?(params["m"])
    date = Date.new(params["y"].to_i, params["m"].to_i, 1)  
  else
    puts "引数が不正です"
    puts "引数を設定する場合は、-yに年数（1970〜2100）、-mに月数（1〜12）を渡してください"
    return
  end

  # 描画する
  printCal(date)
end

def year?(param) 
  if param == nil
    puts "-y 年数の引数がありません"
    return false
  end
  if param.to_i < 1970 || param.to_i > 2100
    puts "-yには年数（1970〜2100）を指定してください"
    return false
  end
  return true
end

def month?(param) 
  if param == nil
    puts "-m 月の引数がありません"
    return false
  end
  if param.to_i < 1 || param.to_i > 12
    puts "-mには月（1〜12）を指定してください"
    return false
  end
  return true
end

def printCal(date)
  result_lines = []
  # 6月 2022
  result_lines.push "#{date.month}月 #{date.year}".center(LINE_LENGTH)

  # 日 月 火 水 木 金 土
  result_lines.push "日 月 火 水 木 金 土"

  # 月の初日と末日
  first_day = 1
  last_day = Date.new(date.year, date.month, -1).day
  week = []

  # 初日から末日まで回して、週ごとに整形処理
  (first_day..last_day).to_a.each do | day |
    week.push(day.to_s.rjust(2))

    # 土曜日になったら
    if Date.new(date.year, date.month, day).saturday? 
      result_lines.push week.join(" ").rjust(LINE_LENGTH)
      week.clear
    end
  end
  # 最終週
  result_lines.push week.join(" ") unless week.empty?

  # 改行入れて描画！
  print result_lines.join( "\n" )
end

# 実行
cal
