# frozen_string_literal: true
require 'debug'

def ls_normal(file)
  files = []
  file.each do |x|
    next if x.match?(/^\./)

    files.push(x)
  end
  files
end

def make_cell(rows, cols, files_sorted)
  rows.each do |row|
    cols.each do |col|
      break if files_sorted[row + col * rows.size].nil?

      print files_sorted[row + col * rows.size].ljust(26)
    end

    puts
  end
end

# debugger
current_directory = Dir.pwd
file = Dir.entries(current_directory)

files = ls_normal(file)

col_num = 3
row_num = (files.size / col_num.to_f).ceil

cols = (0..col_num - 1)
rows = (0..row_num - 1)
files_sorted = files.sort

make_cell(rows, cols, files_sorted)
