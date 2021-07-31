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
  print text_count_lines(text).to_s.rjust(RESULT_WORD_WIDTH)
  unless @option['l']
  puts text_count_words(text).to_s.rjust(RESULT_WORD_WIDTH) + \
       text_count_byte(text).to_s.rjust(RESULT_WORD_WIDTH)
  end
end

def file_result(file_list)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0

  file_list.each do |file|
    print "#{file_count_lines(file).to_s.rjust(RESULT_WORD_WIDTH)}"
    unless @option['l']
      print "#{file_count_words(file).to_s.rjust(RESULT_WORD_WIDTH)}#{file_count_byte(file).to_s.rjust(RESULT_WORD_WIDTH)}"
    end
    puts " #{file}"
    lines_sum += file_count_lines(file)
    words_sum += file_count_words(file)
    byte_sum += file_count_byte(file)
  end

  return unless file_list.size >= 2
  print "#{lines_sum.to_s.rjust(RESULT_WORD_WIDTH)}"
  unless @option['l']
    print "#{words_sum.to_s.rjust(RESULT_WORD_WIDTH)}#{byte_sum.to_s.rjust(RESULT_WORD_WIDTH)}"
  end
  puts " total"
end

main
