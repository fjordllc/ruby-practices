#!/usr/bin/env ruby
# frozen_string_literal: true

def output_by_option(file_name)
  format = '%7s %7s %7s %-10s'
  ft = File::Stat.new(file_name)
  count_lines = IO.readlines(file_name).length # 行数
  read_for_count_words = File.read(file_name) # 単語数
  count_words = read_for_count_words.split(/\s+/).size
  count_bit = ft.size # バイト数
  file_basename = File.basename(file_name) # ファイルネーム
  printf format, count_lines, count_words, count_bit, file_basename
end

def output_without_option(file_name)
  format = '%7s %-10s'
  count_lines = IO.readlines(file_name).length # 行数
  file_basename = File.basename(file_name) # ファイルネーム
  printf format, count_lines, file_basename
end

# オプションや引数による条件分岐
# a = 1
# file_name = 'wc.rb'

if output_by_option(file_name) # オプションあり
else
  output_without_option(file_name)
end
