#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

OUTPUT_COLUMN_NUMBER = 3

def main
  files, max_filename_length = make_files
  output_files(files, max_filename_length)
end

def make_files
  is_specified = parse_option
  absolute_path = make_absolute_path
  files = create_file_list(absolute_path, is_specified)
  sorted_files = files.compact.sort
  aligned_files = align_files(sorted_files)
  two_dimensional_files = make_two_dimensional_array(aligned_files)
  max_filename_length = generate_max_filename_length(two_dimensional_files)
  transposed_files = two_dimensional_files.transpose
  [transposed_files, max_filename_length]
end

def parse_option
  is_specified = {}
  opt = OptionParser.new
  opt.on('-a')
  opt.parse!(ARGV, into: is_specified)
  is_specified
end

def make_absolute_path
  File.expand_path(ARGV[0] || '.')
end

def create_file_list(absolute_path, is_specified)
  Dir.chdir(absolute_path)
  is_specified[:a] ? Dir.glob('*', File::FNM_DOTMATCH).map.to_a : Dir.glob('*').map.to_a
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

def output_files(output_files, max_file_length)
  output_files.each do |files|
    files.each do |file|
      print file.ljust(max_file_length + 2)
    end
    print "\n"
  end
end

main
