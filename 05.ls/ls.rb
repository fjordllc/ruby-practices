def build_display_column
  # 現在のディレクトリのファイル名を取得
  files = Dir.glob("*")
  # 表示するカラムの縦の長さを計算する
  display_column_size = (files.size / 3.0).ceil

  # 3分割後の配列を作成する
  devided_columns = []
  files.each_slice(display_column_size) {|a| devided_columns << a}

  # 文字列の余白を調整する
  adjusted_columns = [] 
  devided_columns.each_with_index do |column, i|
    max_str_count = column.max_by {|v| v.size}.size
    adjusted_columns << column.map {|v| v.ljust(max_str_count + 2)}
  end
  
  if adjusted_columns.last.size != display_column_size
    empty_column_data_size = display_column_size - adjusted_columns.last.size
    count = 0
    while count < empty_column_data_size
      adjusted_columns.last << ''
      count += 1
    end
  end
  adjusted_columns.flatten
  # max_str_count = devided_columns[i].max_by {|v| v.size}.size
  # devided_columns[i].map {|v| v.ljust(max_str_count + 2)}
end

# p build_display_column

# p adjust_display_column.transpose

# print adjust_display_column.transpose

# p adjust_display_column

# print build_display_column[0]
# 1,5,9
# 2,6,10
# 3,7,11
# 4,8,12

# base = build_display_column.flatten
# print base[0]
# print base[4]
# print "#{base[8]}\n"
# print base[1]
# print base[5]
# print "#{base[9]}\n"
# print base[2]
# print base[6]
# print "#{base[10]}\n"
# print base[3]
# print base[7]
# print "#{base[11]}\n"
# display_data
# def display_ls_file
#   build_display_column.each_with_index do |column, index|
#     # columnは"01.fizzbuzz  ", "02.calendar  ", "03.rake      ", "04.bowling   "]のような配列
#     column.each_with_index do |data, index|
#       # dataは"01.fizzbuzz  "のような文字列
#     end
#   end
# end

def display_files
  files = Dir.glob("*")
  display_column_size = (files.size / 3.0).ceil
  # first_row = build_display_column.select.with_index { |_, i| i % n == 0 } #=> [0, 3, 6, 9]
  # second_row = build_display_column.select.with_index { |_, i| i % n == 1 }
  # p first_row
  # p second_row
  (0...display_column_size).each.with_index do |n|
    row = build_display_column.select.with_index { |_, i| i % display_column_size == n }
    row.each.with_index {|row_data, i| print i % 3 == 2 ? "#{row_data}\n" : row_data}
  end
end

display_files

# def hoge(i)
#   print adjust_display_column(i)
# end

# print hoge(0)

# def display_data
#   puts data.map(&:to_i)
# end

# a = display_data
# data = adjust_display_column(0)
# p data
# p display_columns[0]
# # 1つの配列の中で最大の文字数
# max_size1 = display_columns[0].max_by {|v| v.size}.size
# # ↑を使って余白を作る
# p display_columns[0].map {|v| v.ljust(max_size1 + 2)}
# # 1つの配列の中で最大の文字数
# max_size2 = display_columns[1].max_by {|v| v.size}.size
# # ↑を使って余白を作る
# p display_columns[1].map {|v| v.ljust(max_size2 + 2)}
# # 1つの配列の中で最大の文字数
# max_size3 = display_columns[2].max_by {|v| v.size}.size
# # ↑を使って余白を作る
# p display_columns[2].map {|v| v.ljust(max_size3 + 2)}
# p display_columns[0].map {|v| v.ljust(10)}
# p display_columns
# display_columns.each do |column|
#   max_value_size = column[0].size
#   column.each do |value|
#     max_value_size = value.size if max_value_size < value.size
#     value.ljust(100)
#   end
#   p max_value_size
# end

=begin
aaa    aaaaaaaa  aaaaa  
aaaa   aaaaaaa   a      
aaaaa  aaa       aaa    
=end

=begin
とりあえず、間のことは考えずに
111 4444444 7
222222222 55555 88888888
33 666666 9999
みたいに並べることを考える
=end

=begin
下記を実現するパターンは
111  ,44444, 7 改行
みたいな配列をたくさん作成して
1つずつ要素を出力していく
というパターンと
111   ,222222222, 33    改行
みたいな配列を3列分用意して
first[0] second[0] third[0]
first[1] second[1] third[1]
.....
のように表示するパターンのいずれかだと思っている
後者の方が配列は準備しやすそう


111       4444444 7
222222222 55555   88888888
33        666666  9999
=end
