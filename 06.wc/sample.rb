#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  arrays_of_lines = []
  if ARGV.length.zero?
    $stdin.each_line { |line| arrays_of_lines << line }
    output_count_up_total(arrays_of_lines, options)
  else
    ARGV.each do |filenames|
      arrays_of_lines << File.open(filenames, 'r', &:readlines)
    end
    output_result(arrays_of_lines, options)
    if ARGV.length >= 2
      output_count_up_total(arrays_of_lines, options)
      puts ' total'
    end
  end
end

def output_result(arrays_of_lines, options)
  arrays_of_lines.each_index do |i|
    count_lines = arrays_of_lines[i].length
    count_words = arrays_of_lines[i].join.split(/\s+/).length
    count_bites = arrays_of_lines[i].join.bytesize
    file_name = ARGV[i]
    if options['l']
      format_for_l = '%7s %-10s'
      printf format_for_l, count_lines, file_name
    else
      format = '%7s %7s %7s %-10s'
      printf format, count_lines, count_words, count_bites, file_name
    end
    puts "\n"
  end
end

def output_count_up_total(arrays_of_lines, options)
  total_count_lines = arrays_of_lines.flatten.length
  total_count_words = arrays_of_lines.flatten.join.split(/\s+/).length
  total_count_bites = arrays_of_lines.flatten.join.bytesize
  if options['l']
    printf('%7s', total_count_lines)
  else
    format_for_total = '%7s %7s %7s'
    printf format_for_total, total_count_lines, total_count_words, total_count_bites
  end
end

main
