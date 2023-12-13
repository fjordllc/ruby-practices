#! /usr/bin/env ruby
# frozen_string_literal: true

MAX_COL_SIZE = 3

input = ARGV[0]&.to_s || '.'
files = Dir.entries(input).reject { |file| /^\..*/.match(file) }.sort
matrix = []

row_size = if files.empty?
             return
           elsif (files.length % MAX_COL_SIZE).zero?
             files.length / MAX_COL_SIZE
           else
             files.length / (MAX_COL_SIZE - 1)
           end

files.each_slice(row_size) do |col|
  valid_col = col.compact
  max_size = valid_col.max_by(&:length).length
  matrix.push({ col: valid_col, size: max_size })
end

matrix[0][:col].length.times do |i|
  matrix.each do |value|
    print value[:col][i].ljust(value[:size]) if !value[:col][i].nil?
    print "\s\s"
  end
  puts
end
