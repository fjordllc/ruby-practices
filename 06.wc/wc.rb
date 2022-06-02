#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

WC_COMMAND_PRINT_SPACE = 8

def loop_to_count_word(file_or_stdin, loption_flag, number_of_lines, number_of_words, size)
  loop do
    line = file_or_stdin.gets
    break unless line

    number_of_lines += 1
    unless loption_flag
      number_of_words += line.split(' ').size
      size += line.bytesize
    end
  end
  [number_of_lines, number_of_words, size]
end

def print_word_count(file_or_stdin, loption_flag, total)
  number_of_lines = 0
  number_of_words = 0
  size = 0

  number_of_lines, number_of_words, size = loop_to_count_word(file_or_stdin, loption_flag, number_of_lines, number_of_words, size)

  total[:number_of_lines] += number_of_lines
  unless loption_flag
    total[:number_of_words] += number_of_words
    total[:size] += size
  end

  if loption_flag
    print "#{number_of_lines.to_s.rjust(WC_COMMAND_PRINT_SPACE)} "
  else
    print number_of_lines.to_s.rjust(WC_COMMAND_PRINT_SPACE)
    print number_of_words.to_s.rjust(WC_COMMAND_PRINT_SPACE)
    print size.to_s.rjust(WC_COMMAND_PRINT_SPACE)
  end
end

loption_flag = false
opt = OptionParser.new
opt.on('-l') do
  loption_flag = true
end
opt.parse(ARGV)

names_of_file = []
ARGV.each do |file_name|
  names_of_file.push(file_name) unless file_name == '-l'
end

total = {
  number_of_lines: 0,
  number_of_words: 0,
  size: 0
}
case names_of_file.size
when 0
  print_word_count($stdin, loption_flag, total)
  print "\n"
when 1
  file = File.open(names_of_file[0], 'r')
  print_word_count(file, loption_flag, total)
  puts names_of_file[0]
else
  names_of_file.each do |file_name|
    file = File.open(file_name, 'r')
    print_word_count(file, loption_flag, total)
    puts " #{file_name}"
  end

  if loption_flag
    print "#{total[:number_of_lines].to_s.rjust(WC_COMMAND_PRINT_SPACE)} "
  else
    print total[:number_of_lines].to_s.rjust(WC_COMMAND_PRINT_SPACE)
    print total[:number_of_words].to_s.rjust(WC_COMMAND_PRINT_SPACE)
    print total[:size].to_s.rjust(WC_COMMAND_PRINT_SPACE)
  end
  puts ' total'
end
