#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  display_column.each do |column|
    column.each do |file|
      if file == column.last
        print "#{file}\n"
      else
        print file.ljust(column_margin)
      end
    end
  end
end

def define_directory
  file_path = ARGV
  Dir.glob('*', base: file_path[0])
end

def display_column
  max_column_length = 3.0
  display_column_num = (define_directory.size / max_column_length).ceil
  display_column_lists = define_directory.each_slice(display_column_num).to_a
  last_column = display_column_lists.last

  (display_column_num - last_column.size).times { last_column << '' }
  display_column_lists.transpose
end

def column_margin
  length = 0
  margin = 3

  define_directory.each do |file|
    length = file.length.to_i if file.length > length
  end

  length + margin
end

main
