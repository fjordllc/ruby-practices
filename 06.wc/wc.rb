#!/usr/bin/env ruby
# frozen_string_literal: true

FORMAT = "%7s %7s %7s %-10s"
file_name = 'wc.rb'
# file_name = 'sample.txt'

ft = File::Stat.new(file_name)
count_lines = IO.readlines(file_name).length #行数
read_for_count_words = File.read(file_name) # 単語数
count_words = read_for_count_words.split(/\s+/).size
count_bit = ft.size# バイト数
file_basename = File.basename(file_name) # ファイルネーム

printf FORMAT, count_lines, count_words, count_bit, file_basename
