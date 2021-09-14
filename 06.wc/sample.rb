#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  array_of_base_dates = []
  if ARGV.length.zero?
    data_by_standard_input(array_of_base_dates)
    output_count_up_total(array_of_base_dates, options)
  else
    data_by_file(array_of_base_dates)
    output_result(array_of_base_dates, options)
    if ARGV.length >= 2
      output_count_up_total(array_of_base_dates, options)
      puts ' total'
    end
  end
end

def data_by_standard_input(array_of_base_dates)
  while (line = $stdin.gets)
    array_of_base_dates << line
  end
end

def data_by_file(array_of_base_dates)
  ARGV.each do |files|
    base_dates = []
    File.open(files, 'r') { |file| file.map { |lines| base_dates << lines } }
    array_of_base_dates << base_dates
  end
end

def output_result(array_of_base_dates, options)
  array_of_base_dates.each_index do |i|
    count_lines = array_of_base_dates[i].length
    count_words = array_of_base_dates[i].join.split(/\s+/).length
    count_bites = array_of_base_dates[i].join.bytesize
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

def output_count_up_total(array_of_base_dates, options)
  total_count_lines = array_of_base_dates.flatten.length
  total_count_words = array_of_base_dates.flatten.join.split(/\s+/).length
  total_count_bites = array_of_base_dates.flatten.join.bytesize
  if options['l']
    printf('%7s', total_count_lines)
  else
    format_for_total = '%7s %7s %7s'
    printf format_for_total, total_count_lines, total_count_words, total_count_bites
  end
end

main
