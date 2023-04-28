#! /usr/bin/env ruby
# frozen_string_literal: true

columns = 3

# 仮の配列
temporary_outputs = []

# ファイル名の最大文字数
max_file_length = 0

file = ARGV[0] || '.'

# ファイルの取得
Dir.foreach(file) do |item|
  next if item.eql?('.') || item.eql?('..')

  temporary_outputs << item
  max_file_length = item.length if max_file_length < item.length
end

# 一列に出力するファイルの数
max_size = temporary_outputs.length / columns + 1

# 出力する配列
outputs = Array.new(columns) { [] }

# ファイルの並び替えと二次元配列に変える
array_num = 0
temporary_outputs.sort.each do |item|
  outputs[array_num].push(item)
  array_num += 1 if (outputs[array_num].length % max_size).zero?
end

# 出力
max_size.times do |time|
  columns.times do |column|
    print outputs[column][time]
    print ' ' * (max_file_length - outputs[column][time].to_s.length + 1)
  end
  puts "\n"
end
