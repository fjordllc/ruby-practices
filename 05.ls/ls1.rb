# frozen_string_literal: true

# !/usr/bin/env ruby
dir = Dir.glob('*')
dir.sort
arrs = Array.new(3) { [] }
division_number = 3
element_number = Rational(dir.size, division_number).ceil
indent = 0
dir.each do |file|
  arrs[indent] << file
  indent += 1 if (arrs[indent].size % element_number).zero?
end
max_element_number = arrs.map(&:size).max
arrs.map! { |arr| arr.values_at(0...max_element_number) }
row_column_replacement = arrs.transpose
row_column_replacement.each do |arr|
  arr.map! { |x| x.nil? ? '' : x }
end
max_word_count = dir.map(&:length).max
row_column_replacement.each do |arr|
  print arr[0].ljust(max_word_count + 7)
  print arr[1].ljust(max_word_count + 7)
  print arr[2]
  print "\n"
end
