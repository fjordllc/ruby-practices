#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def load_dir(dir)
  Dir.each_child(dir).to_a
end

def sort_list(max_column)
  ls_dir = ARGV[0]
  ls_dir ||= '.'

  directory_list = load_dir(ls_dir)

  max_word_count = directory_list.max_by(&:length).length
  max_row = directory_list.size / max_column + 1

  splited_list = directory_list.sort.each_slice(max_row).to_a

  sorted_list = splited_list.map do |file_names|
    file_names.values_at(0..max_row - 1).map do |file_name|
      file_name ||= ''
      file_name.ljust(5 + max_word_count)
    end
  end

  sorted_list.transpose.each do |c1|
    puts c1.join('')
  end
end

sort_list(3)
