#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('l')

FORMAT = '%7s %7s %7s %-10s'
FORMATFORTOTAL = '%7s %7s %7s'
FORMATFORL = '%7s %-10s'
FORMATFORLTOTAL = '%7s'

def output_result(arrays_of_base_dates, options)
  arrays_of_base_dates.each_index do |i|
    count_lines = arrays_of_base_dates[i].length
    count_words = arrays_of_base_dates[i].to_s.split(/\s+/).size # 空白を取り除く
    count_bites = arrays_of_base_dates[i].to_s.bytesize # おかしい
    file_name = ARGV[i]
    if options['l']
      printf FORMATFORL, count_lines, file_name
    else
      printf FORMAT, count_lines, count_words, count_bites, file_name
    end
    puts "\n"
  end
end

def output_count_up_total(arrays_of_base_dates, options)
  total_count_lines = arrays_of_base_dates.flatten.length
  total_count_words = arrays_of_base_dates.flatten.to_s.split(/\s+/).length
  total_count_bites = arrays_of_base_dates.flatten.to_s.bytesize
  if options['l']
    printf FORMATFORLTOTAL, total_count_lines
  else
    printf FORMATFORTOTAL, total_count_lines, total_count_words, total_count_bites
  end
end

# 「wcコマンドの処理対象を取得するコード」
arrays_of_base_dates = []
if ARGV.length.zero?
  while (line = $stdin.gets)
    arrays_of_base_dates << line.chomp
  end
  output_count_up_total(arrays_of_base_dates, options) # totalなくしたい
else
  ARGV.each do |a|
    base_dates = []
    File.open(a, 'r') do |file|
      file.each do |lines|
        base_dates << lines
      end
      arrays_of_base_dates << base_dates
    end
  end
  output_result(arrays_of_base_dates, options)
  if ARGV.length >= 2
    output_count_up_total(arrays_of_base_dates, options)
    puts ' total'
  end
end
