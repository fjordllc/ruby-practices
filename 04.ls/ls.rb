#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_COL = 3

def get_filenames(target_path)
  Dir.glob('*', base: target_path)
end

def output(filenames)
  number_of_row = ((filenames.size - 1) / NUMBER_OF_COL) + 1
  ljust_widths = []

  split_filenames = filenames.each_slice(number_of_row).to_a

  split_filenames.each do |col|
    ljust_widths << col.map(&:size).max + 2
  end

  number_of_row.times do |row|
    NUMBER_OF_COL.times do |col|
      # split_filenamesのcolとrowを入れ替えて出力
      print split_filenames[col][row].ljust(ljust_widths[col]) unless split_filenames[col][row].nil?
    end
    print "\n"
  end
end

target_path = ARGV[0] || './'
filenames = get_filenames(target_path)
output(filenames)
