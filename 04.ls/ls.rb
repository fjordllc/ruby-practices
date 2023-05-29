#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

OUTPUT_COLUMN_NUMBER = 3

def main
  files, max_filename_length = make_files
  output_files(files, max_filename_length)
end

def make_files
  option = parse_option
  files = create_file_list(make_absolute_path).compact.sort
  files = files.reverse if option[:r]
  two_dimensional_files = make_two_dimensional_array(align_files(files))
  max_filename_length = generate_max_filename_length(two_dimensional_files)
  transposed_files = two_dimensional_files.transpose
  [transposed_files, max_filename_length]
end

def parse_option
  option = {}
  opt = OptionParser.new
  opt.on('-r')
  opt.parse!(ARGV, into: option)
  option
end

def make_absolute_path
  File.expand_path(ARGV[0] || '.')
end

def create_file_list(absolute_path)
  Dir.chdir(absolute_path)
  Dir.glob('*').map.to_a
end

def align_files(sorted_files)
  sorted_files.push(' ') until (sorted_files.length % OUTPUT_COLUMN_NUMBER).zero?
  sorted_files
end

def make_two_dimensional_array(aligned_files)
  aligned_files.each_slice(aligned_files.length / OUTPUT_COLUMN_NUMBER).to_a
end

def generate_max_filename_length(two_dimensional_files)
  two_dimensional_files.flatten.map(&:length).max
end

def count_fullwidth_character(file)
  file.chars.count { |char| char.bytesize == 3 }
end

def output_files(output_files, max_file_length)
  output_files.each do |files|
    files.each do |file|
      print file.ljust((max_file_length - count_fullwidth_character(file)) + 2)
    end
    print "\n"
  end
end

main
