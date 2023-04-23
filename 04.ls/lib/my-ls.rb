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

class Array
  def divide_equal(number)
    split_num = (self.size / number.to_f).ceil
    self.each_slice(split_num).to_a
  end
end

class String
  def size_jp
    split_num = (self.size / number.to_f).ceil
    self.each_slice(split_num).to_a
  end
end

class String
  def size_jp
    count = 0
    self.each_char do |char|
      if char.match?(/\p{Han}|\p{Hiragana}|\p{Katakana}/)
        count += 2
      else
        count += 1
      end
    end
    count
  end

  def ljust_jp(max_size)
    self + ' ' * (max_size - self.size_jp)
  end
end

def generate_name_list_text(file_names, number)
  separatiopn_names = file_names.divide_equal(number)
  max_name_size = file_names.max {|a, b| a.size_jp <=> b.size_jp }.size_jp
  max_names_array_size = separatiopn_names.map(&:size).max
  while separatiopn_names.last.size < max_names_array_size
    separatiopn_names.last << ''
  end
  pp separatiopn_names.transpose
  separatiopn_names.transpose.inject('') do |text, names|
    text += names.map { |n| n.ljust_jp(max_name_size) }.join(' ') + "\n"
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
