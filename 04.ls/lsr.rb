#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
file_name_list = Dir.glob('*')

file_list = []
display_col_size = 3
fold_point = file_name_list.size / display_col_size - 1
file_name_list.each do |name|
  file_list << { name: }
end

display_col_size.times do
  file_list << file_list.slice!(0..fold_point)
end

num = fold_point - file_list.last.size + 1
num.times do
  file_list.last << { name: '' }
end

disp_file_name_array = file_list.transpose

disp_file_name_array.each do |file_array|
  file_array.each do |file|
    print file[:name].ljust(40)
  end
  puts ''
end
