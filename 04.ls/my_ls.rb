#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN_NUMBER = 3
def line_up_files
  files = files_with_space
  files_number = files.count
  rows = files_number / COLUMN_NUMBER
  if files_number % COLUMN_NUMBER != 0
    (COLUMN_NUMBER - files_number % COLUMN_NUMBER).times { files << '' }
    rows += 1
  end
  output(files, rows)
end

def files_with_space
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
