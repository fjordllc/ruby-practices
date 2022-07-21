#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_COUNT = 3
COLUMN_MARGIN = 4

def main
  path = ARGV[0]
  ls(path)
end

def ls(path = '.')
  files = get_files(path)
  columns = slice_columns(files)
  puts format(files, columns)
end

def get_files(path)
  Dir.glob('*', base: path)
end

def slice_columns(files)
  row_count = (files.size / COLUMN_COUNT.to_f).ceil
  columns = []
  files.each_slice(row_count) do |f|
    f.fill('', f.size, row_count - f.size) if f.size < row_count
    columns << f
  end
  columns
end

def format(files, columns)
  column_width = files.max_by(&:length).length + COLUMN_MARGIN
  formated_rows = []
  columns.transpose.each do |row|
    formated_rows << row.map { |f| f.ljust(column_width) }.join
  end
  formated_rows
end

main
