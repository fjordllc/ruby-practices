# frozen_string_literal: true

NUMBER_OF_COLUMNS = 3
LENGTH_OFFSET = 2
SINGLE_BYTE_CHAR_DISPLAY_LENGTH = 1
MULTI_BYTE_CHAR_DISPLAY_LENGTH = 2

def translate_display_char_length(char)
  char.bytesize == 1 ? SINGLE_BYTE_CHAR_DISPLAY_LENGTH : MULTI_BYTE_CHAR_DISPLAY_LENGTH
end

def display_length(string)
  string.each_char.map do |char|
    translate_display_char_length(char)
  end.sum
end

def file_name_lengths(file_names)
  file_names.each.map do |file_name|
    display_length(file_name)
  end.max
end

def print_format_file_name(text, length)
  print format("%-#{length + LENGTH_OFFSET}s", text)
end

def main
  files = Dir.glob('*')

  max_row = (files.length % NUMBER_OF_COLUMNS).zero? ? files.length / NUMBER_OF_COLUMNS : files.length / NUMBER_OF_COLUMNS + 1
  file_names_list = files.each_slice(max_row).to_a

  lengths = file_names_list.map do |file_names|
    file_name_lengths(file_names)
  end

  max_row.times do |row|
    file_names_list.length.times do |col|
      print_format_file_name(file_names_list[col][row], lengths[col])
    end
    puts
  end
end

main
