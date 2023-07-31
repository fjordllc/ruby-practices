#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

NUMBER_OF_COL = 3
SPACE_WIDTH = 2

def search_option
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.parse!(ARGV)
  params
end

def get_filenames(target_path, params)
  if params[:a]
    Dir.entries(target_path).sort
  else
    Dir.glob('*', base: target_path)
  end
end

def output(filenames)
  number_of_row = ((filenames.size - 1) / NUMBER_OF_COL) + 1
  # NOTE: filenames_tableの要素は行と列が出力したい形とは逆で保存されている
  filenames_table = filenames.each_slice(number_of_row).to_a

  widths = filenames_table.map { |col| col.map(&:size).max + SPACE_WIDTH }

  number_of_row.times do |row_index|
    NUMBER_OF_COL.times do |col_index|
      # filenames_tableの行と列が逆で保存されているので、col_indexとrow_indexを入れ替えて出力させている
      target_filename = filenames_table[col_index][row_index]
      print target_filename.ljust(widths[col_index]) unless target_filename.nil?
    end
    print "\n"
  end
end

option = search_option
target_path = ARGV[0] || './'
filenames = get_filenames(target_path, option)
output(filenames)
