#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
COLUMNS = 3
SPACE_FOR_COLUMNS = 2
def make_file_list
  Dir.glob('*')
end

def print_file_list
  files = make_file_list.sort
  rows = files.size / COLUMNS + 1
  lines = []
  max_file_names = []
  files.each_with_index do |file_name, index|
    now_row = index % rows
    now_column = index / rows
    lines[now_row] = [] if now_column.zero?
    max_file_names[now_column] ||= 0

    lines[now_row] << file_name
    max_file_names[now_column] = file_name.size if max_file_names[now_column] < file_name.size
  end
  lines.each do |line|
    line.each_with_index do |element, i|
      print element.ljust(max_file_names[i] + SPACE_FOR_COLUMNS)
    end
    print "\n"
  end
end

print_file_list
