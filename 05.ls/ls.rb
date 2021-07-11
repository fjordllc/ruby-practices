#!/usr/bin/env ruby
# frozen_string_literal: true

# オプションなし
dir_and_file_names = Dir.glob('*')
p dir_and_file_names
p dir_and_file_names.size

# dir_and_file_namesは配列
# 列数を定数に
NumberOfColumn = 3
# 配列の要素数取得、列数で割って行数を出す。
NumberOfLines = dir_and_file_names.length / NumberOfColumn
p NumberOfLines
# dir_and_file_nameの先頭からNumberOfLinesずつ取得したデータで配列を作る。
# それはNumberOfColumn繰り返される。
# できた配列を、要素数 == NumberOfColumnの配列に入れこみ、「配列の配列」を作る
a = dir_and_file_names.each_slice(NumberOfLines + 1).to_a
puts '列の交換'
a[0].zip(a[1], a[2]) { |array6|
  p array6
}

# -a
# all_dir_and_file_name = Dir.glob("*", File::FNM_OUTMATCH)
# p all_dir_and_file_name
