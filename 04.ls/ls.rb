#!/usr/bin/env ruby
# frozen_string_literal: true

COL_MAX = 3
PADDING = 2

def collect_files
  path = ARGV[0]
  path ||= '.'
  Dir.children(path).sort
rescue Errno::ENOENT
  puts '正しいパスを入力してください'
  false
end

def display_files(files)
  files = files.reject { |name| name.start_with?('.') }
  total_files = files.size.to_f
  row_size = (total_files / COL_MAX).ceil
  col_size = (total_files / row_size).ceil
  widths = get_column_width(files, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = files[row + col * row_size]
      display_width = widths[col] + PADDING
      print file_name.ljust(display_width, ' ') unless file_name.nil?
    end
    puts
  end
end

def get_column_width(files, row_size, col_size)
  widths = Array.new(col_size, 0)
  files.each.with_index do |file, index|
    column_number = index / row_size
    widths[column_number] = file.length if file.length > widths[column_number]
  end
  widths
end

files = collect_files
display_files(files) if files
