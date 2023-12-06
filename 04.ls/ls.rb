#! /usr/bin/env ruby
# frozen_string_literal: true

input = ARGV[0]&.to_s || '.'
files = Dir.entries(input).reject { |file| /^\..*/.match(file) }.sort
matrix = []
files.each_slice(4) do |file1, file2, file3, file4|
  row = [file1, file2, file3, file4]
  valid_row = row.compact
  max_size = valid_row.max_by(&:length).length
  matrix.push({ row: valid_row, size: max_size })
end

(0..matrix.length).each do |i|
  matrix.each do |value|
    print value[:row][i].ljust(value[:size]) if !value[:row][i].nil?
    print "\t"
  end
  print "\n"
end
