# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.parse(ARGV)

def make_cell(rows, cols, files_sorted)
  rows.each do |row|
    cols.each do |col|
      break if files_sorted[row + col * rows.size].nil?

      print files_sorted[row + col * rows.size].ljust(26)
    end

    puts
  end
end

if option == { a: true }
  files = Dir.glob('*', File::FNM_DOTMATCH)
else
  files = Dir.glob('*')
end

files_sorted = files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM - 1)
rows = (0..row_num - 1)

make_cell(rows, cols, files_sorted)
