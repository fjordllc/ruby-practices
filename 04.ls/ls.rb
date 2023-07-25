#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_ROW = 3

def get_filenames(target_path)
  Dir.glob('*', base: target_path)
end

def output(filenames)
  number_of_col = ((filenames.size - 1) / NUMBER_OF_ROW) + 1
  ljust_widths = []

  filenames.each_slice(number_of_col) do |row|
    ljust_widths << row.map(&:size).max
  end

  number_of_col.times do |col|
    NUMBER_OF_ROW.times do |row|
      print filenames[col + row * number_of_col].ljust(ljust_widths[row] + 2) if filenames[col + row * number_of_col]
    end
    print "\n"
  end
end

target_path = ARGV[0] || './'
filenames = get_filenames(target_path)
output(filenames)
