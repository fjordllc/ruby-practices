# frozen_string_literal: true

# !/usr/bin/env ruby
NUMBEROFCOLUMNS = 3
dirs = Dir.glob('*').sort
arrs_containing_dirs = Array.new(NUMBEROFCOLUMNS) { [] }
number_of_elements_per_column = Rational(dirs.size, NUMBEROFCOLUMNS).ceil
index = 0
dirs.each do |dir|
  arrs_containing_dirs[index] << dir
  index += 1 if (arrs_containing_dirs[index].size % number_of_elements_per_column).zero?
end
arrs_containing_dirs.map! { |arr| arr.values_at(0...number_of_elements_per_column) }
arrs_with_rows_and_columns_swapped = arrs_containing_dirs.transpose
maximum_number_of_words = dirs.map(&:size).max
arrs_with_rows_and_columns_swapped.each do |arr|
  arr.each do |dir|
    print dir.to_s.ljust(maximum_number_of_words + 7)
  end
  print "\n"
end
