#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  arrays_of_base_dates = []
  if ARGV.length.zero?
    data_by_standard_input(arrays_of_base_dates)
    output_count_up_total(arrays_of_base_dates, options)
  else
    ARGV.each do |files|
      base_dates = []
      File.open(files, 'r') do |file|
        file.map { |lines| base_dates << lines }
      end
      arrays_of_base_dates << base_dates
    end
    output_result(arrays_of_base_dates, options)
    if ARGV.length >= 2
      output_count_up_total(arrays_of_base_dates, options)
      puts ' total'
    end
  end
end

def data_by_standard_input(arrays_of_base_dates)
  while (line = $stdin.gets)
    arrays_of_base_dates << line
  end
end

def output_result(arrays_of_base_dates, options)
  arrays_of_base_dates.each_index do |i|
    count_lines = arrays_of_base_dates[i].length
    count_words = arrays_of_base_dates[i].join.split(/\s+/).length
    count_bites = arrays_of_base_dates[i].join.bytesize
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

def output_count_up_total(arrays_of_base_dates, options)
  total_count_lines = arrays_of_base_dates.flatten.length
  total_count_words = arrays_of_base_dates.flatten.join.split(/\s+/).length
  total_count_bites = arrays_of_base_dates.flatten.join.bytesize
  if options['l']
    printf('%7s', total_count_lines)
  else
    format_for_total = '%7s %7s %7s'
    printf format_for_total, total_count_lines, total_count_words, total_count_bites
  end
end

main
