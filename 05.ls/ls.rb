#!/usr/bin/env ruby
# frozen_string_literal: true

MAXIMUM_COLUMN = 3
require 'optparse'

def main
  params = ARGV.getopts('a')
  dirs = params['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')

  files = []
  total_number_of_files = dirs.size
  number_of_lines = (total_number_of_files.to_f / MAXIMUM_COLUMN).ceil(0)

  slice_the_file(dirs, number_of_lines, files)

  align_the_number_of_elements(files, total_number_of_files)

  sorted_files = files.transpose

  show_files(dirs, sorted_files)
end

def slice_the_file(dirs, number_of_lines, files)
  dirs.each_slice(number_of_lines) { |n| files << n }
end

def align_the_number_of_elements(files, total_number_of_files)
  return unless files.size >= MAXIMUM_COLUMN && total_number_of_files % MAXIMUM_COLUMN != 0

  (MAXIMUM_COLUMN - total_number_of_files % MAXIMUM_COLUMN).to_i.times { files.last << nil }
end

def show_files(dirs, sorted_files)
  longest_name = dirs.max_by(&:size)
  margin = 6
  sorted_files.each do |sorted_file|
    sorted_file.each do |s|
      print s.to_s.ljust(longest_name.size + margin)
    end
    puts
  end
end

main
