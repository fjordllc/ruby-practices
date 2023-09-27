#!/usr/bin/env ruby
# frozen_string_literal: true

SPLIT_NUMBER = 3

def group_files
  find_files = Dir.glob('*')
  max_length = find_files.length / SPLIT_NUMBER
  max_length = find_files.length % SPLIT_NUMBER != 0 ? max_length + 1 : max_length

  grouped_files = find_files.each_slice(max_length).to_a
  hoge = grouped_files[0].length - grouped_files[SPLIT_NUMBER - 1].length
  grouped_files[SPLIT_NUMBER - 1] += Array.new(hoge, nil) if find_files.length % SPLIT_NUMBER != 0
  grouped_files
end

def sort_files(group_files)
  vertical_files = group_files.transpose
  max_name_length = calc_max_value_of_name(group_files)

  vertical_files.each do |files|
    files.each do |file|
      printf("%-#{max_name_length}s\t", file)
    end
    print("\n")
  end
end

def calc_max_value_of_name(group_files)
  name_length = 1
  group_files.each do |files|
    files.each do |file|
      name_length = file.length if name_length < file.length
    end
  end
  name_length
end

sort_files(group_files)
