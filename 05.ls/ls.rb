#!/usr/bin/env ruby
# frozen_string_literal: true

def array_sort(array)
  width = 3
  height = (array.size.to_f / width).ceil

  array = array.each_slice(height).to_a

  ans = []

  height.times do |row|
    num = []
    width.times do |column|
      num << (array[column][row])
    end
    ans << num
  end
  ans
end

def catch_file(directory = Dir.getwd)
  items = []
  Dir.foreach(directory) do |item|
    next if item =~ /^\..*/
    items << item
  end
  items
end

files =
if ARGV[0].nil?
  catch_file()
else
  catch_file(File.absolute_path(ARGV[0]))
end

files = array_sort(files.sort)
files.size.times do |time|
  3.times do |column|
    printf('%-24s', files[time][column])
  end
  puts
end
