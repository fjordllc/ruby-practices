#!/usr/bin/env ruby
# frozen_string_literal: true

files_of_directory = Dir.glob('*')

def make_divided_list(input, num)
  num_to_add = input.size / num
  num_to_add += 1 if input.size % num != 0

  ret = []
  num.times do |i|
    ret << []
    ret[i] << nil while ret[i].size < num_to_add
  end

  k = 0
  ret.size.times do |i|
    j = 0
    while j < num_to_add && k < input.size
      ret[i][j] = input[k]
      j += 1
      k += 1
    end
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
