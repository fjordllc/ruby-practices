#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3
COLUMN_MARGIN = 4

def main
  options = {}
  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  path = opt.parse(ARGV)[0]

  puts ls(options, path)
end

def ls(options, path = '.')
  files = get_files(options, path)
  return '' if files.empty?

  columns = slice_columns(files)
  format(files, columns)
end

def get_files(options, path)
  glob_flag = options[:a] ? File::FNM_DOTMATCH : 0
  files = Dir.glob('*', glob_flag, base: path).sort
  files = files.reverse if options[:r]
  files
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
