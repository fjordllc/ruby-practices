#!/usr/bin/env ruby
# frozen_string_literal: true

def line_up_files
  files_with_space = gets_files
  column = 3
  files_number = files_with_space.count
  if files_number % column != 0
    (column - files_number % column).times { files_with_space << '' }
    rows = files_number / column + 1
  else
    rows = files_number / column
  end

  output_files = []
  files_with_space.each_slice(rows) do |file|
    output_files << file
  end

  output_files.transpose.each do |file|
    file.each { |filename| print filename }
    puts "\n"
  end
end

def gets_files
  files = Dir.glob('*')
  filename_max_length = files.map(&:size).max + 4
  files.map do |file|
    file + ' ' * (filename_max_length - file.size)
  end
end

line_up_files
