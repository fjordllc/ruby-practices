#! /usr/bin/env ruby
# frozen_string_literal: true

Acquired_file_names = Dir.glob('*')
desired_number_of_columns = 3
NUMBER_OF_COLUMN = Acquired_file_names.find { |name| name.size >= 24 } ? 1 : desired_number_of_columns

def insert_empty_filename_and_sort_by_each_columns(filenames, columns)
  copied_filenames = filenames.dup
  copied_filenames << '' while copied_filenames.size % columns != 0
  numbers_of_lines = copied_filenames.size / columns
  copied_filenames.each_slice(numbers_of_lines).to_a.transpose
end

def get_maximum_number_of_characters_each_columns(filenames)
  maximum_number_of_characters = 0
  filenames.each do |name|
    maximum_number_of_characters = name.size if maximum_number_of_characters < name.size
  end
  maximum_number_of_characters
end

def get_number_of_characters_of_filenames_including_margins(filenames)
  case get_maximum_number_of_characters_each_columns(filenames)
  when (0..7)
    8
  when (8..15)
    16
  when (16..23)
    24
  end
end

def display_filenames_with_some_columns(filenames, columns)
  insert_empty_filename_and_sort_by_each_columns(filenames, columns).each do |arr|
    arr.each_with_index do |name, i|
      if i == (NUMBER_OF_COLUMN - 1)
        puts name
      else
        print name.ljust(Number_of_characters_of_filenames_including_margins)
      end
    end
  end
end

Number_of_characters_of_filenames_including_margins = get_number_of_characters_of_filenames_including_margins(Acquired_file_names)
display_filenames_with_some_columns(Acquired_file_names, NUMBER_OF_COLUMN)
