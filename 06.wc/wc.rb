#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')
file_names = ARGV

def output_by_option(file_names)
  file_names.each do |file_name|
    ft = File::Stat.new(file_name)
    count_lines = IO.readlines(file_name).length
    read_for_count_words = File.read(file_name)
    count_words = read_for_count_words.split(/\s+/).size
    count_bites = ft.size
    file_basename = File.basename(file_name)

    format = '%7s %7s %7s %-10s'
    printf format, count_lines, count_words, count_bites, file_basename
    puts "\n"


    # total_outputs(file_names) # if ARGVの要素数が2個以上なら

  end
end

def output_without_option(file_names)
  count_lines = IO.readlines(file_names).length
  file_basename = File.basename(file_names)

  format = '%7s %-10s'
  printf format, count_lines, file_basename

  #トータルを出すメソッド if ARGVの要素数が2個以上なら
end

# main(options)

if options['l']
  output_without_option(file_names)
else
  output_by_option(file_names)
end
