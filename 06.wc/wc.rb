# frozen_string_literal: true

require 'optparse'

@option = ARGV.getopts('l')

def main
  if ARGV.empty?
    text = readline(nil)
    display_stdin_result(text)
  else
    display_file_result(ARGV)
  end
end

RESULT_WORD_WIDTH = 8

def format_count(count)
  count.to_s.rjust(RESULT_WORD_WIDTH)
end

def print_counts(lines_num, words_num, bytes_num, name = nil)
    print format_count(lines_num)
  unless @option['l']
    print format_count(words_num) + \
          format_count(bytes_num)
  end
  puts " #{name}"
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

def display_stdin_result(text)
  print_counts(count_lines(text), count_words(text), count_byte(text))
end

def display_file_result(file_list)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0

  file_list.each do |file|
    text = File.read(file)
    line_count = count_lines(text)
    print_counts(line_count, count_words(text), count_byte(text), file)
    lines_sum += line_count
    words_sum += count_words(text)
    byte_sum += count_byte(text)
  end

  return unless file_list.size >= 2

  print_counts(lines_sum, words_sum, byte_sum, "total")

end

main
