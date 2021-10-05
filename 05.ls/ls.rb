#!/usr/bin/env ruby
# frozen_string_literal: true

files_of_directory = Dir.glob('*')
max_filename_length = files_of_directory.max_by(&:size).size
MARGIN = 2

def make_divided_list(input, num)
  num_to_add = input.size / num
  num_to_add += 1 if input.size % num != 0

  ret = []
  num.times do |i|
    ret << []
    ret[i] << nil while ret[i].size < num_to_add
  end

  ret.size.times do |i|
    j = 0
    while input.size.positive? && j < num_to_add
      ret[i][j] = input.shift
      j += 1
    end
  end
  ret
end

def show_file(divided_list, max_filename_length)
  divided_list.transpose.each do |list|
    list.each do |file|
      print file.to_s.ljust(max_filename_length + MARGIN)
    end
    print "\n"
  end
end

divided_list = make_divided_list(files_of_directory, 3)
show_file(divided_list, max_filename_length)
