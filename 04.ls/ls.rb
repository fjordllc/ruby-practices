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

def acquire_files(selected_dir:, a_option: false, r_option: false)
  files = a_option ? Dir.glob('*', File::FNM_DOTMATCH, base: selected_dir) : Dir.glob('*', base: selected_dir)
  r_option ? files.reverse : files
end

def transpose_by_each_columns(files, columns)
  files << '' while files.size % columns != 0
  lines = files.size / columns
  files.each_slice(lines).to_a.transpose
end

def get_column_width(files)
  max_of_length = files.max_by(&:length).length
  (max_of_length.next..).find { |n| (n % MULTIPLE_OF_COLUMN_WIDTH).zero? }
end

def generate_files_for_display(files, column_number)
  column_width = get_column_width(files)
  transposed_files = transpose_by_each_columns(files, column_number)
  transposed_files.map do |files_each_lines|
    files_each_lines.map { |file| file.ljust(column_width) }.join('')
  end
end

options = select_option
acquired_files = acquire_files(selected_dir: options[:dir], a_option: options[:a], r_option: options[:r])
puts generate_files_for_display(acquired_files, NUMBER_OF_COLUMNS)
