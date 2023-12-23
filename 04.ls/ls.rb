#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COL_MAX = 3
PADDING = 2

def main

  options = { r: false }
  opt = OptionParser.new
  opt.on('-r') { options[:r] = true }
  argv = opt.parse(ARGV)

  path = argv[0] || '.'
  FileTest.directory?(path) or return
  file_names = Dir.children(path).sort
  display_file_names(file_names, options)
end

def display_file_names(file_names, options)

  filtered_file_names = file_names.reject { |name| name.start_with?('.') }
  filtered_file_names = filtered_file_names.reverse if options[:r]
  total_file_names = filtered_file_names.size.to_f
  row_size = (total_file_names / COL_MAX).ceil
  col_size = (total_file_names / row_size).ceil
  widths = get_column_widths(filtered_file_names, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = filtered_file_names[row + col * row_size]
      width = widths[col] + PADDING
      print file_name.ljust(width, ' ') if file_name
    end
    puts
  end
end

def get_column_widths(file_names, row_size, col_size)
  widths = Array.new(col_size, 0)
  file_names.each.with_index do |file_name, index|
    column_index = index / row_size
    widths[column_index] = file_name.length if file_name.length > widths[column_index]
  end
  widths
end

main
