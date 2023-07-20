#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_ROW = 3
target_path = ARGV[0] ||= './'

def get_filenames(target_path)
  Dir.glob("*", base: target_path)
end

def output(filenames)
  number_of_col = ((filenames.size - 1) / NUMBER_OF_ROW) + 1
  filename_array = Array.new(number_of_col) { Array.new(NUMBER_OF_ROW) }

  number_of_col.times do |col|
    NUMBER_OF_ROW.times do |row|
      print "#{filenames[col + row * 5]}   "
    end
    print "\n"
  end
end

filenames = get_filenames(target_path)
output(filenames)
