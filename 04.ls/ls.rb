# frozen_string_literal: true

NUMBER_OF_COLUMNS = 3
LENGTH_OFFSET = 2

def file_name_lengths(file_names)
  file_names.map do |file_name|
    file_name.max_by(&:length).length
  end
end

def print_format_file_name(text, length)
  print format("%-#{length + LENGTH_OFFSET}s", text)
end

def main
  files = Dir.glob('*')

  max_row_length = (files.length % NUMBER_OF_COLUMNS).zero? ? files.length / NUMBER_OF_COLUMNS : files.length / NUMBER_OF_COLUMNS + 1
  file_names = files.each_slice(max_row_length).to_a

  lengths = file_name_lengths(file_names)

  max_row_length.times do |row|
    file_names.length.times do |col|
      print_format_file_name(file_names[col][row], lengths[col])
    end
    puts
  end
end

main
