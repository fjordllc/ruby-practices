# frozen_string_literal: true

def make_cell(rows, cols, files_sorted)
  rows.each do |row|
    cols.each do |col|
      break if files_sorted[row + col * rows.size].nil?

      print files_sorted[row + col * rows.size].ljust(26)
    end

    puts
  end
end

files = Dir.glob('*')

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM)
rows = (0..row_num - 1)
files_sorted = files.sort

make_cell(rows, cols, files_sorted)
