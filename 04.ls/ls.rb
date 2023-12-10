#!/usr/bin/env ruby
# frozen_string_literal: true

COL_MAX = 3
PADDING = 2

def collect_files
  path = ARGV[0]
  path.nil? ? Dir.children('.').sort : Dir.children(path).sort
rescue Errno::ENOENT
  puts '正しいパスを入力してください'
  exit
end

def column_width(files, row_size, col_size)
  width_array = Array.new(col_size) { 0 }
  files.each.with_index do |file, index|
    width_array[index / row_size] = file.length if file.length > width_array[index / row_size]
  end
  width_array
end

def display_files(files)
  files = files.delete_if { |name| name.start_with?('.') }
  total_files = files.size.to_f
  row_size = (total_files / COL_MAX).ceil
  col_size = (total_files / row_size).ceil
  width_array = column_width(files, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = files[row + col * row_size]
      print file_name.ljust(width_array[col] + PADDING, ' ') unless file_name.nil?
    end
    puts
  end
end

display_files(collect_files)
