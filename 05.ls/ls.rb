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
  return '' if files.empty?

  columns = slice_columns(files)
  puts format(files, columns)
end

def get_files(path)
  Dir.glob('*', base: path).sort
end

def slice_columns(files)
  row_count = (files.size / COLUMN_COUNT.to_f).ceil
  files.each_slice(row_count).map do |f|
    f.fill('', f.size, row_count - f.size)
  end
end

def format(files, columns)
  column_width = files.max_by(&:length).length + COLUMN_MARGIN
  columns.transpose.map do |column|
    column.map { |f| f.ljust(column_width) }.join
  end
end

main
