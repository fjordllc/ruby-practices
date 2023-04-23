#!/usr/bin/env ruby
# frozen_string_literal: true
require 'optparse'

LIST_ROW_NAME = 3

def get_file_names(argument_name)
  argument_name ||= ''
  absolute_path = File.expand_path(argument_name)
  target_directory, target_file = path_to_directory_and_file(absolute_path, argument_name)
  select_file(target_directory, target_file)
end

def path_to_directory_and_file(absolute_path, argument_name)
  target_file = ''
  if File.directory?(absolute_path)
    target_directory = absolute_path
  else
    target_directory =  '.'
    target_file = argument_name unless argument_name == ''
  end
  [target_directory, target_file]
end


def select_file(target_directory, target_file)
  file_names_all = Dir.entries(target_directory).sort
  if target_file.empty?
    file_names_all.reject { |file_name| file_name =~ /^\./ }
  else
    file_names_all.select{ |file_name| file_name == target_file}.first
  end  
end


def generate_name_list_text(file_names, number)
  separatiopn_names = file_names.divide_equal(number)
  max_name_size = file_names.max {|a, b| a.size_jp <=> b.size_jp }.size_jp
  separatiopn_names.transpose_lack.inject('') do |text, names|
    text += names.map.with_index(1) do |name, index| 
      index < names.size ? name.ljust_jp(max_name_size) : name
    end.join(' ') + "\n"
  end
end

class Array
  def divide_equal(number)
    split_num = (self.size / number.to_f).ceil
    self.each_slice(split_num).to_a
  end

  def transpose_lack
    max_size = self.map(&:size).max
    (0...max_size).map do |selection_num|
      self.map { |nest_array| nest_array[selection_num] }.compact
    end
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

input = ARGV[0]
file_names = get_file_names(input)
print generate_name_list_text(file_names, LIST_ROW_NAME)
