# frozen_string_literal: true

# !/usr/bin/env ruby
NUMBER_OF_COLUMNS = 3

def dirs
  Dir.glob('*').sort
end

def add_dirs_to_arrs
  arrs_containing_dirs = Array.new(NUMBER_OF_COLUMNS) { [] }
  number_of_elements_per_column = Rational(dirs.size, NUMBER_OF_COLUMNS).ceil
  index = 0
  dirs.each do |dir|
    arrs_containing_dirs[index] << dir
    index += 1 if (arrs_containing_dirs[index].size % number_of_elements_per_column).zero?
  end
  unity_number_of_arr_elements = arrs_containing_dirs.map { |arr| arr.values_at(0...number_of_elements_per_column) }
  unity_number_of_arr_elements.transpose
end

def output_dirs
  maximum_number_of_words = dirs.map(&:size).max
  add_dirs_to_arrs.each do |arr|
    arr.each do |dir|
      print dir.to_s.ljust(maximum_number_of_words + 7)
    end
    puts
  end
end

output_dirs
