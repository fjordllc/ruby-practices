#! /usr/bin/env ruby
# frozen_string_literal: true

columns = 3

temporary_outputs = []

# ファイル名の最大文字数
max_file_length = 0

# ファイルの取得
Dir.foreach('./outputs') do |item|
  next if item.include?('.') || item.include?('..')

  temporary_outputs << item
  max_file_length = item.length if max_file_length < item.length
end

# 一列に出力するファイルの数
max_size = temporary_outputs.length / columns + 1

outputs = Array.new(columns) { [] }

count = 0

# ファイルの並び替えと二次元配列に変える
temporary_outputs.sort.each do |item|
  outputs[count].push(item)
  count += 1 if (outputs[count].length % max_size).zero?
end

# 出力
max_size.times do |time|
  columns.times do |column|
    print outputs[column][time]
    print ' ' * (max_file_length - outputs[column][time].to_s.length + 1)
  end
  puts "\n"
end
