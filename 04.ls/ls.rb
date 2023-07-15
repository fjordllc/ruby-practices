# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.on('-r') { |r| option[:r] = r}
opt.parse(ARGV)

def make_cell(rows, cols, files_ordered)
  rows.each do |row|
    cols.each do |col|
      break if files_ordered[row + col * rows.size].nil?

      print files_ordered[row + col * rows.size].ljust(26)
    end

    puts
  end
end

flags = option[:a] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags)

files_ordered = option[:r] ? files.reverse : files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM - 1)
rows = (0..row_num - 1)

make_cell(rows, cols, files_ordered)
