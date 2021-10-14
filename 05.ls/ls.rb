#!/usr/bin/env ruby
# frozen_string_literal: true

files_of_directory = Dir.glob('*')

def make_divided_list(input, num)
  num_to_add = (input.size.to_f / num).ceil

  ret = Array.new(num) { [] }

  ret.map do |row|
    row << input.shift while row.size < num_to_add
  end
  ret
end

def make_adjustment_width(files_of_directory, multiple)
  max_filename_length = files_of_directory.max_by(&:size).size
  (max_filename_length / multiple + 1) * multiple
end

def show_file(divided_list, adjustment_width)
  divided_list.transpose.each do |list|
    list.each do |file|
      print file.to_s.ljust(adjustment_width)
    end
    print "\n"
  end
end

divided_list = make_divided_list(files_of_directory, 3)
adjustment_width = make_adjustment_width(files_of_directory, 8)
show_file(divided_list, adjustment_width)
