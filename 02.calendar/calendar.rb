#!/usr/bin/env ruby

require 'optparse'
require 'date'

#コマンドライン引数として月(m)と年(y)を受け取る
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

year = params.values[0].to_i
month = params.values[1].to_i

#コマンドラインで受け取った月と年を元にDateインスタンスを生成
#月の初日の情報を取得
date_first = Date.new(year, month, 1)
#月の最終日の情報を取得
date_last = Date.new(year, month, -1)

day_first_temp = date_first.day
date_first_temp = date_first

date_hash = {}

#日付をキー、曜日の番号を値としたハッシュを作成
while day_first_temp <= date_last.day
    date_hash[:"#{day_first_temp}"] = date_first_temp.wday
    date_first_temp += 1
    day_first_temp += 1
end

#カレンダーを出力
puts '      ' + month.to_s + '月 ' + year.to_s
puts '日' + ' 月 ' + '火' + ' 水 ' + '木' + ' 金 ' + '土'
date_hash.each do |key, value|
    if key.to_s.length == 1
        #日付が一桁の場合は、整合をとるために前にも空白を付与する
        pre_branks = ' '
        if key.to_s == "1"
            #初日が日曜日以外の場合、そのまま出力すると曜日と日付が合わないので
            #曜日番号に応じて前に付与する空白の数を変えて出力する位置をずらす
            value.times do 
                #曜日番号が1増えるごとに、空白を3つ増やす
                pre_branks += '   '
            end
        end
        print(pre_branks + key.to_s + ' ')
    elsif
        print(key.to_s + ' ')
    end
    #土曜日まで出力したら改行
    if value == 6
        print("\n")
    end
end

