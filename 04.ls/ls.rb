#!/usr/bin/env ruby
# frozen_string_literal: true

SPLIT_NUMBER = 3

def group_files
  obtained_files = Dir.glob('*')
  max_length = (obtained_files.length.to_f / SPLIT_NUMBER).ceil

  grouped_files = obtained_files.each_slice(max_length).to_a
  blank_numbers = grouped_files[0].length - grouped_files[-1].length
  grouped_files[-1] += Array.new(blank_numbers, nil)
  grouped_files
end

def output_like_ls_command(completed_grouped_files)
  vertical_files = completed_grouped_files.transpose
  max_name_length = calc_max_value_of_name(completed_grouped_files)

  vertical_files.each do |files|
    files.each do |file|
      print "#{file}".ljust(max_name_length).concat("\s")
    end
    print("\n")
  end
end

def calc_max_value_of_name(completed_grouped_files)
  Dir.glob('*').map(&:size).max
end

output_like_ls_command(group_files)
