#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

MAX_COLUMN = 3

def print_file_list
  file_list = fetch_file_list
  max_word_count = file_list.max_by(&:length).length
  max_row = file_list.size / MAX_COLUMN + 1

  separated_list = file_list.sort.each_slice(max_row).to_a

  formatted_list = separated_list.map do |file_names|
    file_names.values_at(0..max_row - 1).map do |file_name|
      file_name.to_s.ljust(5 + max_word_count)
    end
  end

  puts formatted_list.transpose.map(&:join)
end

def fetch_file_list
  options = ARGV.getopts('a')
  ls_dir = ARGV[0] || '.'

  file_list = Dir.foreach(ls_dir).to_a

  if options['a']
    file_list
  else
    file_list.reject { |file_name| file_name.start_with?('.') }
  end
end

print_file_list
