require 'date'
day = Date.today

year = day.year
month = day.month

require 'optparse'
opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }

opt.parse!(ARGV)
# 読み込んで、使いやすくする
# まずはopt.parse!(ARGV)を読み込まないと3〜４行目は動かない。

# p ARGV
# ARGVはただ入れた情報を読み込んでそのままarrayとして入れているだけのもの。opt.parse!で動くようになる。


print "#{month}月"
puts " #{year}"

puts "日 月 火 水 木 金 土"

end_of_date = Date.new(year, month, -1).day
#-1は一番最後の日にち取得


start_of_date = Date.new(year, month, 1).wday
#曜日の番号を習得するにはwdayを使う！
#最初の日にちの曜日番号の取得

youbi = 0
while youbi < start_of_date
    youbi += 1
    print "."
end
#youbi = 3


num = 0
while num < end_of_date do
    num += 1
    
    case 
    when (youbi)%7 == 0 && num < 10
        print "#{num}".rjust(2)
    #曜日が０かつ、数字が１０未満だったら
    when (youbi)%7 == 0 
        print num
    #曜日が０だったら
    else 
        print " " + "#{num}".rjust(2)
    end

    # case 
    # when (youbi)%7 == 0 && num < 10
    #     print "#{num}".rjust(2)
    # #曜日が０かつ、数字が１０未満だったら
    # when (youbi)%7 == 0 
    #     print num
    # #曜日が０だったら
    # when num < 10
    #     print "#{num}".rjust(3)
    # else 
    #     print "#{num}".rjust(3)
    # end

    # case 
    # when (youbi)%7 == 0 && num < 10
    #     print "_#{num}"
    # #曜日が０かつ、数字が１０未満だったら
    # when (youbi)%7 == 0 
    #     print num
    # #曜日が０だったら
    # when num < 10
    #     print "__#{num}"
    # else 
    #     print "_#{num}"
    # end

    #　↓ 前書いたコード（念の為残しておく）
    # if (youbi)%7 == 0
    #     print num
    # elsif
    #     num < 10
    #     print "__#{num}"
    # else
    #     print "_#{num}"
    # end

    if ((youbi+=1)%7 == 0)
        #曜日は0〜６までなので、numにプラス１することで、７の倍数が作れる。
      puts
    end
end
#始まりは、その前のwhileのコードで最後のyoubiの数字が3なので、その情報が最後のwhileで引き継がれている。

