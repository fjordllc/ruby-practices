#!/usr/bin/env ruby
# frozen_string_literal: true

FIND_FILES = Dir.glob('*')
SPLIT_NUMBER = 3

def splitting_array
  max_length = FIND_FILES.length / SPLIT_NUMBER
  FIND_FILES.length % SPLIT_NUMBER != 0 ? max_length += 1 : max_length

  split_array = FIND_FILES.each_slice(max_length).to_a
  split_array[2] += Array.new(split_array[0].length - split_array[2].length, nil) if FIND_FILES.length % SPLIT_NUMBER != 0
  split_array
end

def sorting_array(array)
  transpose_arrays = array.transpose
  transpose_arrays.each do |f|
    puts f.join("\t")
  end
end

sorting_array(splitting_array)
