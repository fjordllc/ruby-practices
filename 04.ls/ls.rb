#!/usr/bin/env ruby
# frozen_string_literal: true

OUTPUT_COLUMN_NUMBER = 3

def main
  path = ARGV[0] || '.'
  files = create_file_list(path)
  sorted_files = files.compact.sort
  aligned_files = align_files(sorted_files)
  two_dimensional_files = make_two_dimensional_array(aligned_files)
  max_file_length = generate_max_file_length(two_dimensional_files)
  transposed_files = two_dimensional_files.transpose
  output_files(transposed_files, max_file_length)
end

def create_file_list(path)
  Dir.open(path).each_child.map do |filename|
    filename unless filename[0] == '.'                                            # 隠しファイルの除去
  end
end

def align_files(sorted_files)
  sorted_files.push(' ') until (sorted_files.length % OUTPUT_COLUMN_NUMBER).zero? # 要素数の調整のための追加
  sorted_files
end

def make_two_dimensional_array(aligned_files)
  aligned_files.each_slice(aligned_files.length / OUTPUT_COLUMN_NUMBER).to_a      # 二次元配列に変換
end

def generate_max_file_length(two_dimensional_files)
  max_file_length = {}
  two_dimensional_files.each_with_index do |files, files_index|
    max_file_length.store(files_index, files.map(&:length).max)                   # ハッシュに各列の最大文字数を格納
  end
  max_file_length
end

def output_files(output_files, max_file_length)
  output_files.each do |files|
    files.each_with_index do |file, file_index|
      print file.ljust(max_file_length[file_index % OUTPUT_COLUMN_NUMBER] + 2)    # 最大文字数+2を出力
    end
    print "\n"
  end
end

main
