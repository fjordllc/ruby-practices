#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  filenames = ARGV
  text_strings = filenames.empty? ? [$stdin.read] : filenames.map { |filename| File.read(filename) }
  params = options['l'] == true ? { word: false, byte: false } : {}
  numbers_counted_list = word_count(text_strings, **params)
  show_text_data(filenames, numbers_counted_list)
end

def word_count(text_strings, line: true, word: true, byte: true)
  numbers_counted_list = text_strings.map do |str|
    numbers_counted = []
    numbers_counted << count_lines(str) if line
    numbers_counted << count_words(str) if word
    numbers_counted << count_bytes(str) if byte
    numbers_counted
  end
  # 引数にファイルを複数指定した場合、合計値も出す
  text_strings.size > 1 ? calculate_total(numbers_counted_list) : numbers_counted_list
end

def count_lines(str)
  str.count("\n")
end

def count_words(str)
  str.split(/\s+/).size
end

def count_bytes(str)
  str.bytesize
end

def calculate_total(numbers_counted_list)
  total_numbers = numbers_counted_list.transpose.map(&:sum)
  numbers_counted_list << total_numbers
end

def show_text_data(filenames, numbers_counted_list)
  line_list = make_line_list(filenames, numbers_counted_list)

  line_list.each do |line|
    puts line.join
  end
end

def make_line_list(filenames, numbers_counted_list)
  adjustment_num = make_adjustment_num(numbers_counted_list)
  line_list = numbers_counted_list.map do |numbers_counted|
    numbers_counted.map do |num|
      num.to_s.rjust(adjustment_num)
    end
  end
  # 引数にファイルを指定した場合にfilename、ファイルが複数なら文字列totalも追加する
  filenames.empty? ? line_list : add_word(filenames, line_list)
end

def make_adjustment_num(numbers_counted_list)
  max_size = numbers_counted_list.flatten.max.to_s.size
  # 数値が8桁以上になる場合は空白を1つ設ける。本家wcの仕様が分からなかっため決め打ち
  max_size >= 8 ? max_size + 1 : 8
end

def add_word(filenames, line_list)
  # line_list内の各fileに対応する値が入っている要素にfilenameを追加
  filenames.each_with_index do |filename, i|
    line_list[i] << " #{filename}"
  end
  # line_list内の合計値が入っている要素に文字列totalを追加
  line_list.last << ' total' if filenames.size > 1
  line_list
end

main
