#!/usr/bin/env ruby
# frozen_string_literal: true

def line_up_files
  files_with_space = gets_files
  Column = 3
  files_number = files_with_space.count
  rows = files_number / column
  if files_number % column != 0
    (column - files_number % column).times { files_with_space << '' }
    rows += 1
  end
  out_put(files_with_space, rows)
end

def gets_files
  files = Dir.glob('*')
  filename_max_length = files.map(&:size).max + 7
  files.map do |file|
    file + ' ' * (filename_max_length - file.size)
  end
end

def out_put(files, rows)
  output_files = []
  files.each_slice(rows) do |file|
    output_files << file
  end

  output_files.transpose.each do |file|
    file.each { |filename| print filename }
    puts "\n"
  end
end

line_up_files
