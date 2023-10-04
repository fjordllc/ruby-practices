#!/usr/bin/env ruby
# frozen_string_literal: true

SPLIT_NUMBER = 3

def group_files
  obtained_files = Dir.glob('*')
  max_length = (obtained_files.length.to_f / SPLIT_NUMBER).ceil

  grouped_files = obtained_files.each_slice(max_length).to_a
  blank_numbers = grouped_files[0].length - grouped_files[SPLIT_NUMBER - 1].length
  grouped_files[SPLIT_NUMBER - 1] += Array.new(blank_numbers, nil)
  grouped_files
end

def transpose_columns_and_rows(classified_files)
  vertical_files = classified_files.transpose
  max_name_length = calc_max_value_of_name(group_files)

  vertical_files.each do |files|
    files.each do |file|
      printf("%-#{max_name_length}s\t", file)
    end
    print("\n")
  end
end

def calc_max_value_of_name(classified_files)
  name_length = 1

  classified_files.each do |files|
    files.compact.max { |file| name_length = file.length }
  end
  name_length
end

transpose_columns_and_rows(group_files)
