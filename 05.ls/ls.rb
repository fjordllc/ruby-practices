# !/usr/bin/env ruby
# frozen_string_literal: true

TAB_WIDTH = 8
COLUMN_COUNT = 3

file_names = Dir.glob("*").sort

longest_file_name = file_names.max_by(&:size).size
width = TAB_WIDTH * (longest_file_name / TAB_WIDTH.to_f).ceil

formatted_file_names = file_names.map {|file_name| file_name.ljust(width)}

row_count = (file_names.size.to_f / COLUMN_COUNT).ceil
nested_file_names = formatted_file_names.each_slice(row_count).to_a

nested_file_names = nested_file_names.map { |inner_file_names| inner_file_names.values_at(0...row_count) }
nested_file_names.transpose.each do |file|
  puts file.join(' ')
end
