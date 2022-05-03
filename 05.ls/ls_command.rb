#! /usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_LINES = 3

def measure_number_of_rows(directories_and_files)
  number_of_rows = directories_and_files.size / NUMBER_OF_LINES
  number_of_rows += 1 unless (directories_and_files.size % NUMBER_OF_LINES).zero?
  number_of_rows
end

def measure_max_name_length_of_directory_and_file(directories_and_files)
  max_name_length_of_directory_and_file = 0
  directories_and_files.each do |directory_and_file|
    max_name_length_of_directory_and_file = directory_and_file.length if max_name_length_of_directory_and_file < directory_and_file.length
  end
  max_name_length_of_directory_and_file
end

def print_directories_and_files(directories_and_files, number_of_rows, max_name_length_of_directory_and_file)
  (1..number_of_rows).each do |row|
    (1..NUMBER_OF_LINES).each do |line|
      print directories_and_files[number_of_rows * (line - 1) + row - 1].to_s.ljust(max_name_length_of_directory_and_file + 2)
      space_or_newline = line == NUMBER_OF_LINES ? "\n" : ' '
      print space_or_newline
    end
  end
end

directories_and_files = Dir.glob('*')
number_of_rows = measure_number_of_rows(directories_and_files)
max_name_length_of_directory_and_file = measure_max_name_length_of_directory_and_file(directories_and_files)
print_directories_and_files(directories_and_files, number_of_rows, max_name_length_of_directory_and_file)
