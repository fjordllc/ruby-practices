#!/usr/bin/env ruby#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  arrays_of_lines = []
  if ARGV.length.zero?
    $stdin.each_line { |line| arrays_of_lines << line }
    print_total_file(options, arrays_of_lines)
  else
    ARGV.each do |filename|
      arrays_of_lines << File.readlines(filename)
    end
    result = convert_each_file(arrays_of_lines)
    print_each_file(result, options)
    if ARGV.length >= 2
      print_total_file(options, arrays_of_lines)
      puts ' total'
    end
  end
end

def convert_each_file(arrays_of_lines)
  result = []
  arrays_of_lines.each_with_index do |arrays_of_line, i|
    hash_for_each_file = {
      count_lines: arrays_of_line.flatten.length,
      count_words: arrays_of_line.join.split(/\s+/).length,
      count_bites: arrays_of_line.join.bytesize,
      file_name: ARGV[i]
    }
    result << hash_for_each_file
  end
  result
end

def print_each_file(result, options)
  result.each_with_index do |_m, n|
    if options['l']
      format_for_l = '%7s %-10s'
      printf format_for_l, result[n][:count_lines], result[n][:file_name]
    else
      format = '%7s %7s %7s %-10s'
      printf format, result[n][:count_lines], result[n][:count_words], result[n][:count_bites], result[n][:file_name]
    end
    puts "\n"
  end
end

def print_total_file(options, arrays_of_lines)
  hash_for_total_file = {
    count_lines: arrays_of_lines.flatten.length,
    count_words: arrays_of_lines.join.split(/\s+/).length,
    count_bites: arrays_of_lines.join.bytesize
  }
  if options['l']
    printf('%7s', hash_for_total_file[:count_lines])
  else
    format_for_total = '%7s %7s %7s'
    printf format_for_total,
           hash_for_total_file[:count_lines],
           hash_for_total_file[:count_words],
           hash_for_total_file[:count_bites]
  end
end

main
