#!/usr/bin/env ruby

require 'date'
require 'optparse'

begin
  # コマンドラインオプションを取得する
  # 年、または月が指定されていない場合は本日時点の情報を利用する
  params = ARGV.getopts("y:","m:")

  year = params['y'].nil?  ? Date.today.year : params['y'].to_i
  month = params['m'].nil? ? Date.today.month : params['m'].to_i

  # 月には1から12までのみ指定可能とする
  if month < 1  or month > 12
    raise StandardError.new("-m option must between 1 and 12. ")
  end
rescue => e
  puts e.message
  exit
end

# 年、月は後から標準入力オプションに変更
day_of_week = ["日","月","火","水","木","金","土"]

# ヘッダー部出力
puts "      #{month}月 #{year}"
puts day_of_week.join(' ')

# データ部出力
w_month = []
w_week = ["  ","  ","  ","  ","  ","  ","  "]

date_obj = Date.new(year, month, 1)

while date_obj.month == month
  str_day = date_obj.day.to_s

  w_week[date_obj.wday] = str_day.rjust(2," ")

  # 土曜日の日付が登録されている場合、次から翌週して扱う
  if date_obj.saturday?
    w_month.push(w_week)
    w_week = ["","","","","","",""]
  end

  # 翌日が翌月となる場合は、その時点のデータを最終週として扱う
  if date_obj.next.month > month
    w_month.push(w_week)
  end

  date_obj = date_obj.next
end

w_month.each do | week |
  puts week.join(" ")
end
