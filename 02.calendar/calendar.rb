require "date"
today = Date.today

require 'optparse'



# コマンドライン引数の設定
opt = OptionParser.new
params = opt.getopts('m:','y:')

# コマンドライン引数が設定されていない時の年月の表示
if params["m"]== nil && params ["y"] == nil
    month = today.mon
    year = today.year
    print  "       #{today.mon}月#{today.year}\n"


else
# コマンドライン引数が設定されている時の年月の表示

    month = params["m"].to_i
    year = params["y"].to_i
    print  "       #{month}月#{year}\n"
end

# コマンドライン引数が設定されていない時の月末月初の設定
if params["y"].to_i == nil && month = params["m"].to_i == nil
    firstDay = Date.new(today.year, today.mon, 1)
    lastDay = Date.new(today.year, today.mon, -1)


else
# コマンドライン引数が設定されている時の月末月初の設定

    firstDay = Date.new(year, month, 1)
    lastDay = Date.new(year, month, -1)

end



# 曜日の表示
day_of_week = ["日", "月", "火", "水", "木", "金", "土"]
day_of_week.each { |d| print d, " " }
puts




#  1行目の空白（初日が何曜日始まりかを表す）のコード
if firstDay.wday == 0 
    print ""
elsif firstDay.wday == 1
    print "   "
elsif firstDay.wday == 2
    print "      "

elsif firstDay.wday == 3
    print "         "
    
elsif firstDay.wday == 4
    print"            "
    
elsif firstDay.wday == 5
    print"               "

elsif firstDay.wday == 6
    print"                  "
end



# 月末までの数字を表すコード
for number in firstDay.day..lastDay.day do
    # 数字が10未満の時は前後に空白、10以上の時は後ろだけに空白
    if number < 10
        print (" #{number} ")
    else
        print ("#{number} ")

    end

    # 土曜日の時に改行する
    if Date.new(year, month, number).wday == 6
       print "\n"
    end


end


