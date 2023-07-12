# frozen_string_literal: true

require 'debug'
require 'optparse'
# debugger
opt = OptionParser.new
option = {}
opt.on('-a') {|a| option[:a] = a }
argv = opt.parse(ARGV)

def make_cell(rows, cols, files_sorted)
  # debugger
    rows.each do |row|
      cols.each do |col|
        break if files_sorted[row + col * rows.size].nil?

        print files_sorted[row + col * rows.size].ljust(26)
      end

      puts
      end
end

def option_a_make_cell(rows, cols, a_option_files_sorted)
  rows.each do |row|
    cols.each do |col|
      break if a_option_files_sorted[row + col * rows.size].nil?

      print a_option_files_sorted[row + col * rows.size].ljust(26)
    end

    puts
  end
end

files = Dir.glob('*')
a_option_files = Dir.glob("*", File::FNM_DOTMATCH)
files_sorted = files.sort
a_option_files_sorted = a_option_files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM)
rows = (0..row_num - 1)

if option == {:a => true}
  option_a_make_cell(rows, cols, a_option_files_sorted)
else
  make_cell(rows, cols, files_sorted)
end
