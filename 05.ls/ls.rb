#!/usr/bin/env ruby
# frozen_string_literal: true

# オプションなし
dir_and_file_names = Dir.glob('*')
p dir_and_file_names

# dir_and_file_namesは配列
# 列数を定数に
NumberOfColumn = 3
# 配列の要素数取得、列数で割って行数を出す。
NumberOfLines = dir_and_file_names.length / NumberOfColumn
p NumberOfLines
# dir_and_file_nameの先頭からNumberOfLinesずつ取得したデータで配列を作る。
# それはNumberOfColumn繰り返される。
# できた配列を、要素数 == NumberOfColumnの配列に入れこみ、「配列の配列」を作る
# dir_and_file_nameがNumberOfLinesで割り切れる時とそうでない時で条件分岐。
# NumberOfLinesで割り切れる時はNumberOfLinesで、それ以外はNumberOfLinesで割る
# result = []
a = dir_and_file_names.each_slice(NumberOfLines + 1).to_a

FORMAT = "%20s"
# a[0].zip(a[1], a[2]) do |array|
#   # printf FORMAT, array
#   # result << array #戻り値として利用できる
# end

#ブロックは渡さないので、戻り値を利用できる
# results = a[0].zip(a[1], a[2]).flatten
#indexが3でわってあまりがだったら、改行を加える それ以外は加えない。
# フォーマットを適応させる

results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts "\n"
  end

# -a
# all_dir_and_file_name = Dir.glob("*", File::FNM_OUTMATCH)
# p all_dir_and_file_name
