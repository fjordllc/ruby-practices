#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

NUMBER_OF_COL_MAX = 3
SPACE_WIDTH = 2

def search_option(argv)
  opt = OptionParser.new
  options = {}
  opt.on('-a') { |v| options[:a] = v }
  file_paths = opt.parse(argv)
  retrun options, file_paths
end

def get_filenames(target_path, options)
  dotmatch_flag = options[:a] ? File::FNM_DOTMATCH : 0
  Dir.glob('*', dotmatch_flag, base: target_path)
end

def output(filenames)
  return if filenames.empty?

  number_of_row = ((filenames.size - 1) / NUMBER_OF_COL_MAX) + 1
  number_of_col = filenames.size < NUMBER_OF_COL_MAX ? filenames.size : NUMBER_OF_COL_MAX

  # NOTE: OS標準のlsコマンドは横並びではなく縦並びで出力される(転置して出力される)
  # NOTE: filenames_tableの要素は行と列が出力したい形(縦並び)とは逆で保存されている
  filenames_table = filenames.each_slice(number_of_row).to_a
  widths = filenames_table.map { |col| col.map(&:size).max + SPACE_WIDTH }

  number_of_row.times do |row_index|
    number_of_col.times do |col_index|
      # filenames_tableの行と列が逆で保存されているので、col_indexとrow_indexを入れ替えて出力させている
      target_filename = filenames_table[col_index][row_index]
      print target_filename&.ljust(widths[col_index])
    end
    print "\n"
  end
end

options, file_paths = search_option(ARGV)
target_path = file_paths[0] || './'
filenames = get_filenames(target_path, options)
output(filenames)
