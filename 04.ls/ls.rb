#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OR_ROW = 3
target_path = ARGV[0] ||= './'

def get_filenames(target_path)
  Dir.entries(target_path).sort
end

def output(filenames)
  number_of_col = ((filenames.size - 1) / NUMBER_OR_ROW) + 1
  filename_array = Array.new(number_of_col) { Array.new(NUMBER_OR_ROW) }

  filenames.each_with_index do |filename, index|
    filename_array[index % number_of_col][index / number_of_col] = filename
  end

  filename_array.each do |col|
    col.compact.each do |filename|
      print "#{filename}   "
    end
    print "\n"
  end
end

filenames = get_filenames(target_path)
output(filenames)
