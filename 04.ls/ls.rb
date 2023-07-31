#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'debug'

NUMBER_OF_COL = 3
MULTIPLE_OF_COL_WIDTH = 8

def select_option
  params = {}
  opt = OptionParser.new
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
  params[:dir] = opt.parse!(ARGV)[0]
  params
end

def acquire_files(selected_dir:, a_option: false, r_option: false)
  files = a_option ? Dir.glob('*', File::FNM_DOTMATCH, base: selected_dir) : Dir.glob('*', base: selected_dir)
  r_option ? files.reverse : files
end

def transpose_by_each_col(files, number_of_col)
  files << '' while files.size % number_of_col != 0
  numbers_of_lines = files.size / number_of_col
  files.each_slice(numbers_of_lines).to_a.transpose
end

def get_col_width(files)
  maximum_number_of_characters = files.max_by(&:size).size
  (maximum_number_of_characters.next..).find { |n| (n % MULTIPLE_OF_COL_WIDTH).zero? }
end

def generate_files_for_display(files, number_of_col)
  col_width = get_col_width(files)
  transposed_files = transpose_by_each_col(files, number_of_col)
  transposed_files.map do |files_each_lines|
    files_each_lines.map { |file| file.ljust(col_width) }.join('')
  end
end

options = select_option
acquired_files = acquire_files(selected_dir: options[:dir], a_option: options[:a], r_option: options[:r])
puts generate_files_for_display(acquired_files, NUMBER_OF_COL)
