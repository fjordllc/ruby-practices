#! /usr/bin/env ruby
# frozen_string_literal: true

acquired_file = Dir.glob('*')
NUMBER_OF_COLUMN = 3

def transposed_by_each_columns(files, number_of_columns)
  files << '' while files.size % number_of_columns != 0
  numbers_of_lines = files.size / number_of_columns
  files.each_slice(numbers_of_lines).to_a.transpose
end

def get_column_width(files)
  i = 1
  maximum_number_of_characters = files.max_by(&:size).size
  i += 1 until maximum_number_of_characters < (8 * i)
  8 * i
end

def display(files, number_of_columns)
  transposed_files = transposed_by_each_columns(files, number_of_columns)
  transposed_files.each do |files_each_lines|
    files_with_mergins = files_each_lines.map { |file| file.ljust(get_column_width(files)) }
    puts files_with_mergins.join('')
  end
end

display(acquired_file, NUMBER_OF_COLUMN)
