#!/usr/bin/env ruby
# frozen_string_literal: true

OUTPUT_COLUMN_NUMBER = 3

def main
  files, max_filename_length = make_files
  output_files(files, max_filename_length)
end

def make_files
  absolute_path = make_absolute_path
  files = create_file_list(absolute_path)
  sorted_files = files.compact.sort
  aligned_files = align_files(sorted_files)
  two_dimensional_files = make_two_dimensional_array(aligned_files)
  max_filename_length = generate_max_filename_length(two_dimensional_files)
  transposed_files = two_dimensional_files.transpose
  [transposed_files, max_filename_length]
end

def make_absolute_path
  File.expand_path(ARGV[0] || '.')
end

def create_file_list(absolute_path)
  Dir.chdir(absolute_path)
  Dir.glob('*').map.to_a do |filename|
    filename unless filename.chars.first == '.'
  end
end

def align_files(sorted_files)
  sorted_files.push(' ') until (sorted_files.length % OUTPUT_COLUMN_NUMBER).zero?   # 要素数調整のため空白を追加
  sorted_files
end

def make_two_dimensional_array(aligned_files)
  aligned_files.each_slice(aligned_files.length / OUTPUT_COLUMN_NUMBER).to_a
end

def generate_max_filename_length(two_dimensional_files)
  max_filename_length = 0
  two_dimensional_files.each do |files|
    filename_length = files.map(&:length).max
    max_filename_length = filename_length if max_filename_length < filename_length  # ハッシュに各列の最大文字数を格納
  end
  max_filename_length
end

def output_files(output_files, max_file_length)
  output_files.each do |files|
    files.each do |file|
      print file.ljust(max_file_length + 2)
    end
    print "\n"
  end
end

main
