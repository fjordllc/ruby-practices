#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  file_list = make_list
  return if file_list.size.zero?

  display(file_list)
end

def make_list
  options = ARGV.getopts('a', 'r')
  list = Dir.glob('*', options['a'] ? File::FNM_DOTMATCH : 0).sort
  options['r'] ? list.reverse : list
end

def display(file_list)
  display_width = `tput cols`.to_i

  max_columns = 3
  longest_name_size = file_list.max_by(&:size).size
  minus_columns = (0...max_columns).find { longest_name_size < display_width / (max_columns - _1) } || max_columns - 1
  columns_number = max_columns - minus_columns

  columns_width = display_width / columns_number

  vertical = (file_list.size / columns_number.to_f).ceil

  slice = file_list.map { |d| d.ljust(columns_width) }.each_slice(vertical).to_a

  slice.map { |element| element.values_at(0...vertical) }.transpose.each { |display| puts display.join('') }
end

main
