#! /usr/bin/env ruby
# frozen_string_literal: true

MAX_COL_SIZE = 3

# 表示用行列を生成
def create_matrix(files, max_col_size)
  matrix = []
  row_size = files.length / max_col_size + 1
  files.each_slice(row_size) do |col|
    valid_col = col.compact
    max_size = valid_col.max_by(&:length).length
    matrix.push({ col: valid_col, size: max_size })
  end
  matrix
end

# ファイルを表示
def show_files(matrix)
  matrix[0][:col].length.times do |i|
    matrix.each do |value|
      print value[:col][i].ljust(value[:size]) if !value[:col][i].nil?
      print "\s\s"
    end
    puts
  end
end

path = ARGV[0]&.to_s || '.'
files = Dir.entries(path).reject { |file| file.start_with?('.') }.sort

return if files.empty?

matrix = create_matrix(files, MAX_COL_SIZE)
show_files(matrix)
