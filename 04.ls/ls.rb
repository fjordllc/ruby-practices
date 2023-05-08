#! /usr/bin/env ruby
# frozen_string_literal: true

# 3列
columns = 3
# 引数にディレクトリを指定(初期値はカレントディレクトリ)
directory_path = ARGV[0] || '.'

# 出力するファイルの取得
def get_file(path)
  # 仮の配列
  temporary_outputs = []

  Dir.foreach(path) do |item|
    next if item.include?(".") || item.include?('..')
    temporary_outputs << item
  end
  temporary_outputs
end

# 最大文字数の取得
def get_max_length(array)
  max_file_length = 0

  array.map do |file|
    max_file_length = file.length if max_file_length < file.length
  end
  max_file_length
end

# ファイルの並び替えと二次元配列に変える
def sort_and_covert(array, columns, size)
  # 出力する配列
  outputs = Array.new(columns) { [] }

  array_num = 0
  array.sort.each do |item|
    outputs[array_num] << item
    array_num += 1 if (outputs[array_num].length % size).zero?
  end
  outputs
end

# 出力
def output_file(size, columns, length, array)
  size.times do |time|
    columns.times do |column|
      print array[column][time]
      print ' ' * (length - array[column][time].to_s.length + 1)
    end
    puts "\n"
  end
end

temporary_outputs = get_file(directory_path)
max_file_length = get_max_length(temporary_outputs)
# 一列に出力するファイルの数
max_size = temporary_outputs.length / columns + 1
outputs = sort_and_covert(temporary_outputs, columns, max_size)

output_file(max_size, columns, max_file_length, outputs)
