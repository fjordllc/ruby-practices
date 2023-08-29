# frozen_string_literal: true

require 'optparse'

INITIAL_COLUMN = 3

def parse_file
  options = ARGV.getopts('a')
  options['a'] ? Dir.entries('.').sort : Dir.glob('*').sort
end

def calculate_row_and_space(all_files)
  div, mod = all_files.size.divmod(INITIAL_COLUMN)
  total_row = mod.zero? ? div : (div + 1)
  width = all_files.max_by(&:length).length + 7
  [total_row, width]
end

def ls(all_files, total_row, width)
  all_sort_files = all_files.each_slice(total_row).to_a
  total_row.times do |col|
    INITIAL_COLUMN.times do |row|
      file_name = all_sort_files[row][col]
      print file_name.ljust(width) unless file_name.nil?
    end
    puts
  end
end

all_files = parse_file
total_row, width = calculate_row_and_space(all_files)
ls(all_files, total_row, width)
