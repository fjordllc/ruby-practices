#!/usr/bin/env ruby
# frozen_string_literal: true
#
require 'optparse'
options = ARGV.getopts('a', 'r')

FORMAT = '%-20s'

NumberOfColumn = 3

dir_and_file_names =
  if options['a'] && options['r']
    Dir.glob('*', File::FNM_DOTMATCH).reverse
  elsif options['a']
    Dir.glob('*', File::FNM_DOTMATCH)
  elsif options['r']
    Dir.glob('*').reverse
  else
    Dir.glob('*')
  end

number_of_lines = dir_and_file_names.length / NumberOfColumn
if dir_and_file_names.length % number_of_lines == 0
  a = dir_and_file_names.each_slice(number_of_lines).to_a
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts "\n"
  end
else
  a = dir_and_file_names.each_slice(number_of_lines + 1).to_a
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts
  end
end
