#!/usr/bin/env ruby
# frozen_string_literal: true

dir = Dir.glob('*')

maximum_column = 3.0
total_number_of_files = dir.size
number_of_lines = (total_number_of_files.to_f / maximum_column).ceil(0)

files = []
dir.each_slice(number_of_lines) { |n| files << n }

if files.size >= maximum_column && total_number_of_files % maximum_column != 0
  (maximum_column - total_number_of_files % maximum_column).to_i.times { files[-1] << nil }
end

def show_files(dir, files)
  sorted_files = files.transpose
  longest_name = dir.max_by(&:size)
  margin = 6
  sorted_files.each do |sorted_file|
    sorted_file.each do |s|
      print s.to_s.ljust(longest_name.size + margin)
    end
    print "\n"
  end
end

show_files(dir, files)
