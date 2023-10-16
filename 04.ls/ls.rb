#!/usr/bin/env ruby
# frozen_string_literal: true

SPLIT_NUMBER = 3

def main
  vertical_files = group_files.transpose
  max_name_length = obtain_files.map(&:size).max

  vertical_files.each do |files|
    files.each do |file|
      print file.to_s.ljust(max_name_length + 1)
    end
    print("\n")
  end
end

def obtain_files
  Dir.glob('*')
end

def group_files
  obtained_files = obtain_files
  max_length = (obtained_files.length.to_f / SPLIT_NUMBER).ceil

  grouped_files = obtained_files.each_slice(max_length).to_a
  blank_numbers = grouped_files[0].length - grouped_files[-1].length
  grouped_files[-1] += Array.new(blank_numbers, nil)
  grouped_files
end

output_like_ls_command
