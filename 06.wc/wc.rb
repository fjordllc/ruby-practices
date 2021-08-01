# frozen_string_literal: true

require 'optparse'

def main
  option = ARGV.getopts('l')
  if ARGV.empty?
    text = readline(nil)
    display_stdin_result(text: text, option: option)
  else
    display_file_result(file_list: ARGV, option: option)
  end
end

def display_stdin_result(text:, option: false)
  line_count = count_lines(text)
  word_count = count_words(text)
  byte_count = count_byte(text)
  print_counts(lines_num: line_count, words_num: word_count, bytes_num: byte_count, file_name: nil, option: option)
end

def display_file_result(file_list:, option: nil)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0
  file_list.each do |file|
    text = File.read(file)
    line_count = count_lines(text)
    word_count = count_words(text)
    byte_count = count_byte(text)
    print_counts(lines_num: line_count, words_num: word_count, bytes_num: byte_count, file_name: file, option: option)
    lines_sum += line_count
    words_sum += word_count
    byte_sum += byte_count
  end

  return unless file_list.size >= 2

  print_counts(lines_num: lines_sum, words_num: words_sum, bytes_num: byte_sum, file_name: 'total', option: option)
end

def print_counts(lines_num:, words_num:, bytes_num:, file_name: nil, option: false)
  print format_count(lines_num)
  print format_count(words_num) + format_count(bytes_num) unless option['l']
  puts " #{file_name}"
end

def count_lines(text)
  text.each_line.count
end

def count_words(text)
  text.split(/\n|\t| +|　+/).count
end

def count_byte(text)
  text.bytesize
end

RESULT_WORD_WIDTH = 8
def format_count(count)
  count.to_s.rjust(RESULT_WORD_WIDTH)
end

main
