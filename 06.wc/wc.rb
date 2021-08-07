#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')
file_name = ARGV[0]

def output_by_option(file_name)
  format = '%7s %7s %7s %-10s'
  ft = File::Stat.new(file_name)
  count_lines = IO.readlines(file_name).length
  read_for_count_words = File.read(file_name)
  count_words = read_for_count_words.split(/\s+/).size
  count_bites = ft.size
  file_basename = File.basename(file_name)
  printf format, count_lines, count_words, count_bites, file_basename
end

def output_without_option(file_name)
  format = '%7s %-10s'
  count_lines = IO.readlines(file_name).length
  file_basename = File.basename(file_name)
  printf format, count_lines, file_basename
end

if options['l']
  output_by_option(file_name)
else
  output_without_option(file_name)
end
