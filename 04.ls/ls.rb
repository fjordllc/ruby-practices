#! /usr/bin/env ruby
# frozen_string_literal: true

Acquired_file_names = Dir.glob('*')
NUMBER_OF_COLUMN = 3

def get_filename_the_longest_number_of_characters(filenames)
  longest_number_of_characters = 0
  filenames.each do |name|
    longest_number_of_characters = name.size if longest_number_of_characters < name.size
  end
  longest_number_of_characters
end

def sort_files_for_display_with_some_columns(filenames, columns)
  copied_filename = filenames.dup
  copied_filename << '' while copied_filename.size % columns != 0
  numbers_of_lines = copied_filename.size / columns
  copied_filename.each_slice(numbers_of_lines).to_a.transpose
end

def display_with_some_columns(filename)
  filename.each do |arr|
    arr.each_with_index do |name, i|
      if i == (NUMBER_OF_COLUMN - 1)
        puts name&.ljust(get_filename_the_longest_number_of_characters(Acquired_file_names) + 5)
      else
        print name&.ljust(get_filename_the_longest_number_of_characters(Acquired_file_names) + 5)
      end
    end
  end
end

display_with_some_columns(sort_files_for_display_with_some_columns(Acquired_file_names, NUMBER_OF_COLUMN))
