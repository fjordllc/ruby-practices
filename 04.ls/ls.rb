#!/usr/bin/env ruby
# frozen_string_literal: true

COL_MAX = 3
PADDING = 2

def main
  path = ARGV[0] if ARGV[0]
  files = if path
            collect_files(path) if FileTest.directory?(path)
          else
            collect_files
          end
  files ? display_files(files) : puts('正しいパスを入力してください')
end

def collect_files(path = nil)
  path ||= '.'
  Dir.children(path).sort
end

def display_files(files)
  preprocessed_files = files.reject { |name| name.start_with?('.') }
  total_files = preprocessed_files.size.to_f
  row_size = (total_files / COL_MAX).ceil
  col_size = (total_files / row_size).ceil
  widths = get_column_width(preprocessed_files, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = preprocessed_files[row + col * row_size]
      width = widths[col] + PADDING
      print file_name.ljust(width, ' ') if file_name
    end
    puts
  end
end

def get_column_width(files, row_size, col_size)
  widths = Array.new(col_size, 0)
  files.each.with_index do |file, index|
    column_index = index / row_size
    widths[column_index] = file.length if file.length > widths[column_index]
  end
  widths
end

main
