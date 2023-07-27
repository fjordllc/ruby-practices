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

  ljust_widths = filenames_table.map{|cols| cols.map(&:size).max + SPACE_WIDTH}

  number_of_row.times do |row|
    NUMBER_OF_COL.times do |col|
      target_filename = filenames_table[col][row] #colとrowを入れ替えて出力させる
      print target_filename.ljust(ljust_widths[col]) unless target_filename.nil?
    end
    print "\n"
  end
end

target_path = ARGV[0] || './'
filenames = get_filenames(target_path)
output(filenames)
