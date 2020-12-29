#!/usr/bin/env ruby

require 'optparse'
require 'date'

#コマンドラインの練習お試しコード(一応残しておく)
#params = ARGV.getopts('' , 'abc')
#p params

#ひとまず、2020年12月をカレンダーっぽく表示できるようにコードをかく
#12月の初日の情報を取得
date = Date.new(2020, 12, 1)
#12月の最終日の情報を取得
date2 = Date.new(2020, 12, -1)

day_temp = date.day
date_temp = date

date_hash = {}

#日付をキー、曜日の番号を値としたハッシュを作成
while day_temp <= date2.day
    date_hash[:"#{day_temp}"] = date_temp.wday
    date_temp += 1
    day_temp += 1
end

#ハッシュの中身確認用
#puts date_hash

puts '         12月' ' 2020'
print('日', ' 月 ', '火', ' 水 ', '木', ' 金 ', '土')
print("\n")
date_hash.each do |key, value|
    print(key.to_s + ' ')
    if value == 6
        print("\n")
    end
end
