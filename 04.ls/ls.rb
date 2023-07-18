#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'debug'

NUMBER_OF_COLUMNS = 3
MULTIPLE_OF_COLUMN_WIDTH = 8

def select_option
  params = {}
  opt = OptionParser.new
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
  params[:dir] = opt.parse!(ARGV)[0]
  params
end

SELECTED_OPTION = select_option

def acquire_files(a_option: false)
  if a_option
    Dir.glob('*', File::FNM_DOTMATCH, base: SELECTED_OPTION[:dir])
  else
    Dir.glob('*', base: SELECTED_OPTION[:dir])
  end
end

def transpose_by_each_columns(files, number_of_columns)
  files << '' while files.size % number_of_columns != 0
  numbers_of_lines = files.size / number_of_columns
  files.each_slice(numbers_of_lines).to_a.transpose
end

def get_column_width(files)
  maximum_number_of_characters = files.max_by(&:size).size
  (maximum_number_of_characters.next..).find { |n| (n % MULTIPLE_OF_COLUMN_WIDTH).zero? }
end

def display(files, number_of_columns)
  column_width = get_column_width(files)
  transposed_files = transpose_by_each_columns(files, number_of_columns)
  transposed_files.each do |files_each_lines|
    files_with_mergins = files_each_lines.map { |file| file.ljust(column_width) }
    puts files_with_mergins.join('')
  end
end

display(acquire_files(a_option: SELECTED_OPTION[:a]), NUMBER_OF_COLUMNS)
