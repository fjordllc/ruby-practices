#!/usr/bin/env ruby
# frozen_string_literal: true

def get_file_names(argument_name)
  target_file = ''
  absolute_path = File.expand_path(argument_name)
  if File.directory?(absolute_path)
    target_directory = absolute_path
  else
    target_directory =  '.'
    target_file = argument_name unless argument_name == ''
  end
  
  file_names_all = Dir.entries(target_directory).sort
  if target_file.empty?
    file_names_all.reject { |file_name| file_name =~ /^\./ }
  else
    file_names_all.select{ |file_name| file_name == target_file}.first
  end
end

# disp_column = file_names.each_slice(3).map{|n| n}

# (0..disp_column.size - 1).each do
#   print(disp_column[])
# end



# file_names = Dir.foreach('.') do |file_name|
#   next if file_name == '.' || file_name == '..' || file_name =~ /^./
# end
# p file_names
