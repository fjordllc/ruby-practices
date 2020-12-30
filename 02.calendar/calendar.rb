#!/usr/bin/env ruby

require 'optparse'
require 'date'

#コマンドライン引数として月(m)と年(y)を受け取る
params = ARGV.getopts("y:", "m:")

year = params.values[0].to_i
month = params.values[1].to_i

#コマンドラインで受け取った月と年を元にDateインスタンスを生成
#月の初日の情報を取得
date = Date.new(year, month, 1)
#月の最終日の情報を取得
date2 = Date.new(year, month, -1)

day_temp = date.day
date_temp = date

date_hash = {}

#日付をキー、曜日の番号を値としたハッシュを作成
while day_temp <= date2.day
    date_hash[:"#{day_temp}"] = date_temp.wday
    date_temp += 1
    day_temp += 1
end

#カレンダーを出力
print('      ' + month.to_s + '月 ' + year.to_s)
print("\n")
print('日', ' 月 ', '火', ' 水 ', '木', ' 金 ', '土')
print("\n")
date_hash.each do |key, value|
    if key.to_s.length == 1
        print(' ' + key.to_s + ' ')
    elsif  
        print(key.to_s + ' ')
    end
    #土曜日まで出力したら改行
    if value == 6
        print("\n")
    end
end
