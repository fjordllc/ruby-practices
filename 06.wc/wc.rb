#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')
file_names = ARGV

def output_by_option(file_names)
  file_names.each do |file_name|
    count_lines = IO.readlines(file_name).length
    file_basename = File.basename(file_name)
    format = '%7s %-10s'
    printf format, count_lines, file_basename
    puts "\n"
  end
end

def output_without_option(file_names)
  file_names.each do |file_name|
    count_lines = IO.readlines(file_name).length
    count_words = File.read(file_name).split(/\s+/).size
    count_bites = File::Stat.new(file_name).size
    file_basename = File.basename(file_name)

    format = '%7s %7s %7s %-10s'
    printf format, count_lines, count_words, count_bites, file_basename
    puts "\n"
  end
end

def upto_count_lines(file_names)
  file_names.map { |file_name| IO.readlines(file_name).size }.sum
end

def upto_count_words(file_names)
  file_names.map { |file_name| File.read(file_name).split(/\s+/).size }.sum
end

def upto_count_bites(file_names)
  file_names.map { |file_name| File::Stat.new(file_name).size }.sum
end

if options['l']
  output_by_option(file_names)
  if ARGV.length >= 2
    total_count_lines = upto_count_lines(file_names)
    format = '%7s %-10s'
    # printf format, upto_count_lines(file_names), 'total'
    printf format, total_count_lines, 'total'
  end
else
  output_without_option(file_names)
  if ARGV.length >= 2
    total_count_lines = upto_count_lines(file_names)
    total_count_words = upto_count_words(file_names)
    total_count_bites = upto_count_bites(file_names)
    format = '%7s %7s %7s %-10s'
    printf format, total_count_lines, total_count_words, total_count_bites, 'total'
  end
end
