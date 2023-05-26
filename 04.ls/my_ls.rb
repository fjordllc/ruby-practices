#!/usr/bin/env ruby
# frozen_string_literal: true
COLUMN = 3
def line_up_files
  files_with_space = gets_files
  files_number = files_with_space.count
  rows = files_number / COLUMN
  if files_number % COLUMN != 0
    (COLUMN - files_number % COLUMN).times { files_with_space << '' }
    rows += 1
  end
  output(files_with_space, rows)
end

def gets_files
  files = Dir.glob('*')
  filename_max_length = files.map(&:size).max + 7
  files.map { |file| file.ljust(filename_max_length) }
end

def output(files, rows)
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
