#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_COL = 3
SPACE_WIDTH = 2

def get_filenames(target_path)
  Dir.glob('*', base: target_path)
end

def output(filenames)
  number_of_row = ((filenames.size - 1) / NUMBER_OF_COL) + 1
  filenames_table = filenames.each_slice(number_of_row).to_a

  widths = filenames_table.map { |filenames| filenames.map(&:size).max + SPACE_WIDTH }

  number_of_row.times do |row_index|
    NUMBER_OF_COL.times do |col_index|
      target_filename = filenames_table[col_index][row_index] # colとrowを入れ替えて出力させる
      print target_filename.ljust(widths[col_index]) unless target_filename.nil?
    end
    print "\n"
  end
end

target_path = ARGV[0] || './'
filenames = get_filenames(target_path)
output(filenames)
