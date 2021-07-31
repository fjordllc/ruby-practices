# frozen_string_literal: true

require 'optparse'

@option = ARGV.getopts('l')

def main
  if ARGV.empty?
    text = readline(nil)
    stdin_result(text)
  else
    file_result(ARGV)
  end
end

RESULT_WORD_WIDTH = 8

def format_count(count)
  count.to_s.rjust(RESULT_WORD_WIDTH)
end

def text_count_lines(text)
  text.each_line.count
end

def text_count_words(text)
  text.split(/\n|\t| +|　+/).count
end

def text_count_byte(text)
  text.bytesize
end

def file_count_lines(file)
  text = File.read(file)
  text_count_lines(text)
end

def file_count_words(file)
  text = File.read(file)
  text_count_words(text)
end

def file_count_byte(file)
  text = File.read(file)
  text_count_byte(text)
end

def stdin_result(text)
  print format_count(text_count_lines(text))
  unless @option['l']
    puts format_count(text_count_words(text)) + \
         format_count(text_count_byte(text))
  end
end

def file_result(file_list)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0

  file_list.each do |file|
    text = File.read(file)
    line_count = text_count_lines(text)
    print "#{format_count(line_count)}"
    unless @option['l']
      print "#{format_count(text_count_words(text))}#{format_count(text_count_byte(text))}"
    end
    puts " #{file}"
    lines_sum += line_count
    words_sum += text_count_words(text)
    byte_sum += text_count_byte(text)
  end

  return unless file_list.size >= 2
  print "#{format_count(lines_sum)}"
  unless @option['l']
    print "#{format_count(words_sum)}#{format_count(byte_sum)}"
  end
  puts " total"
end

main
