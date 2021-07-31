# frozen_string_literal: true

require 'optparse'

def main
  option = ARGV.getopts('l')
  if ARGV.empty?
    text = readline(nil)
    display_stdin_result(text, option)
  else
    display_file_result(ARGV, option)
  end
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

def print_counts(lines_num, words_num, bytes_num, name: nil, option: false)
  print format_count(lines_num)
  print format_count(words_num) + format_count(bytes_num) unless option['l']
  puts " #{name}"
end

def display_stdin_result(text, option: false)
  print_counts(count_lines(text), count_words(text), count_byte(text), nil, option)
end

def display_file_result(file_list, option: nil)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0
  file_list.each do |file|
    text = File.read(file)
    line_count = count_lines(text)
    print_counts(line_count, count_words(text), count_byte(text), file, option)
    lines_sum += line_count
    words_sum += count_words(text)
    byte_sum += count_byte(text)
  end

  return unless file_list.size >= 2

  print_counts(lines_sum, words_sum, byte_sum, 'total', option)
end

main
