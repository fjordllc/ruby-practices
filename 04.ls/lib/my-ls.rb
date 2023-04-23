#!/usr/bin/env ruby
# frozen_string_literal: true

file_names_all = Dir.entries('.').sort
file_names = []
file_names_all.each do |file_name|
  next if file_name =~ /^\./
  file_names << file_name
end

disp_column = file_names.each_slice(3).map{|n| n}

(0..disp_column.size - 1).each do
  print(disp_column[])
end

p disp_column[0]
p disp_column[1]
p disp_column[2]


# file_names = Dir.foreach('.') do |file_name|
#   next if file_name == '.' || file_name == '..' || file_name =~ /^./
# end
# p file_names
