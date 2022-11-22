#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
COLUMNS = 3
SPACE_FOR_COLUMNS = 2
def make_file_list
  Dir.glob('*')
end

def make_disp_lines
  files = make_file_list.sort
  rows = files.size / COLUMNS + 1
  lines = []
  max_file_names = []
  files.each_with_index do |file_name, i|
    now_row = i % rows
    now_column = i / rows
    lines[now_row] = [] if now_column.zero?
    max_file_names[now_column] ||= 0

    lines[now_row] << file_name
    max_file_names[now_column] = file_name.size if max_file_names[now_column] < file_name.size
  end
  add_space_for_line(lines, max_file_names)
end

def add_space_for_line(lines, max_file_names)
  result = []
  lines.each do |filenames|
    disp_line = ''
    filenames.each_with_index do |filename, i|
      disp_line += filename.ljust(max_file_names[i] + SPACE_FOR_COLUMNS)
    end
    result << disp_line
  end
  result
end

make_disp_lines.each { |line| puts line }
