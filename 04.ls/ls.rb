# frozen_string_literal: true

require 'optparse'

def main(row)
  path = set_paramater
  files = find_files(path)
  formatted_files = format_files(files)
  vertical_lines = sort_files(formatted_files, row)
  display_files(vertical_lines, row)
end

def set_paramater
  path = '*'
  option = OptionParser.new
  option.on('-a') { path = '{.,*}{.,*}' }
  option.parse!(ARGV)
  path
end

def find_files(path)
  Dir.glob(path)
end

def format_files(files)
  most_long_name = files.max_by(&:length)
  files.map { |file| file.ljust(most_long_name.length + 4) }
end

def sort_files(formatted_files, row)
  sorted_files = formatted_files.sort
  vertical_lines = []
  number_of_lines = (sorted_files.length.to_f / row).ceil
  number_of_lines.times do |col_index|
    row.times do |row_index|
      vertical_lines << sorted_files[col_index + number_of_lines * row_index]
    end
  end
  vertical_lines
end

def display_files(vertical_lines, row)
  vertical_lines.each_with_index { |file, index| print ((index + 1) % row).zero? ? "#{file}\n" : file }
end

main(3)
