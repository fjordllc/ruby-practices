#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require 'optparse'

def parse_option
  opt = OptionParser.new
  option = {}
  opt.on('-a') { |boolean| option[:a] = boolean }
  opt.parse(ARGV)

  if option_a?(option)
    File::FNM_DOTMATCH
  else
    0
  end
end

def option_a?(option)
  option.key?(:a)
end

def define_directory
  Dir.glob('*', parse_option)
end

def display_column
  max_column_length = 3.0
  display_column_num = (define_directory.size / max_column_length).ceil
  display_column_lists = define_directory.each_slice(display_column_num).to_a
  last_column = display_column_lists.last

  (display_column_num - last_column.size).times { last_column << '' }
  display_column_lists.transpose
end

def column_margin
  length = define_directory.map(&:length).max
  margin = 3
  length + margin
end

def main
  display_column.each do |column|
    column.each do |file|
      print file.ljust(column_margin)
    end
    puts ''
  end
end

main
