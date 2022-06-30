#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

MAX_COLUMN = 3

def print_dir_list
  directory_list = set_dir

  max_word_count = directory_list.max_by(&:length).length
  max_row = directory_list.size / MAX_COLUMN + 1

  separated_list = directory_list.sort.each_slice(max_row).to_a

  sorted_list = separated_list.map do |file_names|
    file_names.values_at(0..max_row - 1).map do |file_name|
      file_name ||= ''
      file_name.ljust(5 + max_word_count)
    end
  end

  puts sorted_list.transpose.map(&:join)
end

def set_dir
  options = ARGV.getopts('a')
  ls_dir = ARGV[0] || '.'

  if options['a']
    Dir.foreach(ls_dir).to_a
  else
    Dir.foreach(ls_dir).to_a.reject { |i| /^\./.match?(i) == true }
  end
end

print_dir_list
