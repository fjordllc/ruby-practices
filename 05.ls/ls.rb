#!/usr/bin/env ruby
# frozen_string_literal: true

def sort_array(array)
  width = 3
  height = (array.size.to_f / width).ceil
  answer_array = []

  if array.size < 3
    middle_array = []
    array.size.times do |time|
      middle_array << array[time]
    end
    return answer_array << middle_array
  end

  array = array.each_slice(height).to_a
  height.times do |row|
    middle_array = []
    width.times do |column|
      middle_array << (array[column][row])
    end
    answer_array << middle_array
  end
  answer_array
end

def catch_file(directory = Dir.getwd)
  items = []
  Dir.foreach(directory) do |item|
    next if /^\..*/.match?(item)

    items << item
  end
  items
end

files =
  if ARGV[0].nil?
    catch_file
  else
    catch_file(File.absolute_path(ARGV[0]))
  end

files = sort_array(files.sort)
files.size.times do |time|
  3.times do |column|
    printf('%-24s', files[time][column])
  end
  puts
end
