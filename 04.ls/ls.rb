#!/usr/bin/env ruby

# frozen_string_literal: true

NUMBER_OF_COLUMNS = 3
SINGLE_BYTE_CHAR_DISPLAY_LENGTH = 1
MULTI_BYTE_CHAR_DISPLAY_LENGTH = 2
OFFSET_SPACES = '  '

def translate_display_char_length(char)
  char.bytesize == 1 ? SINGLE_BYTE_CHAR_DISPLAY_LENGTH : MULTI_BYTE_CHAR_DISPLAY_LENGTH
end

def display_length(text)
  text.each_char.map { |char| translate_display_char_length(char) }.sum
end

def max_file_name_length(file_names)
  file_names.each.map { |file_name| display_length(file_name) }.max
end

def print_format_file_name(file_names_hash)
  spaces = ' ' * (file_names_hash[:max_length] - file_names_hash[:length])
  print "#{file_names_hash[:name]}#{spaces}#{OFFSET_SPACES}"
end

def main
  argv = ARGV[0] || ''
  files = Dir.glob('*', base: argv)
  return if files.empty?

  max_row = (files.length % NUMBER_OF_COLUMNS).zero? ? files.length / NUMBER_OF_COLUMNS : files.length / NUMBER_OF_COLUMNS + 1
  file_names_list = files.each_slice(max_row).to_a

  file_names_hash = file_names_list.map do |file_names|
    max_length = max_file_name_length(file_names)
    file_names.each.map do |name|
      length = display_length(name)
      { name:, length:, max_length: }
    end
  end

  max_row.times do |row|
    file_names_hash.length.times do |col|
      print_format_file_name(file_names_hash[col][row]) if file_names_hash[col][row]
    end
    puts
  end
end

main
