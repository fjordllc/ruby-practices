#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_ROW = 3

def get_filenames(target_path)
  Dir.glob('*', base: target_path)
end

def output(filenames)
  number_of_col = ((filenames.size - 1) / NUMBER_OF_ROW) + 1
  ljust_widths = []

  split_filenames = filenames.each_slice(number_of_col).to_a

  split_filenames.each do |row|
    ljust_widths << row.map(&:size).max + 2
  end

  number_of_col.times do |col|
    NUMBER_OF_ROW.times do |row|
      # split_filenamesのcolとrowを入れ替えて出力
      print split_filenames[row][col].ljust(ljust_widths[row]) unless split_filenames[row][col].nil?
    end
    print "\n"
  end
end

target_path = ARGV[0] || './'
filenames = get_filenames(target_path)
output(filenames)
