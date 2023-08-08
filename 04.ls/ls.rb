#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

NUMBER_OF_COL_MAX = 3
SPACE_WIDTH = 2

def search_option(argv)
  opt = OptionParser.new
  option_params = {}
  opt.on('-a') { |v| option_params[:a] = v }
  arguments_without_options = opt.parse(argv)
  return option_params, arguments_without_options
end

def get_filenames(target_path, params)
  if params[:a]
    Dir.glob('*', File::FNM_DOTMATCH, base: target_path, sort: true)
  else
    Dir.glob('*', base: target_path, sort: true)
  end
end

def output(filenames)
  return if filenames.empty?

  number_of_row = ((filenames.size - 1) / NUMBER_OF_COL_MAX) + 1
  number_of_col =
    if filenames.size < NUMBER_OF_COL_MAX
      filenames.size
    else
      NUMBER_OF_COL_MAX
    end
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

option_params, arguments_without_options = search_option(ARGV)
target_path = arguments_without_options[0] || './'
filenames = get_filenames(target_path, option_params)
output(filenames)
