# frozen_string_literal: true

require 'optparse'

ROW_NUM = 3
ROW_MAX_WIDTH = 24

def no_command_main
  all_files = Dir.glob('*').sort
  column_num = all_files.length / ROW_NUM
  files_in_columns = get_transposed_all_files(all_files, column_num)
  display(files_in_columns)
end

def a_command_main
  all_files = Dir.glob('*', File::FNM_DOTMATCH).sort
  column_num = all_files.length / ROW_NUM
  files_in_columns = get_transposed_all_files(all_files, column_num)
  display(files_in_columns)
end


def get_transposed_all_files(all_files, column_num)
  all_files.push(' ') while all_files.length % ROW_NUM != 0
  transposed_files = all_files.each_slice(column_num).to_a.transpose
  transposed_files.first(column_num).each do |column|
    ROW_NUM.times do |index|
      column[index] += ' ' * (ROW_MAX_WIDTH - column[index].length)
    end
  end
end

def display(files_in_columns)
  files_in_columns.each do |column|
    puts column.join
  end
end

opt = OptionParser.new
opt.on('-a') { a_command_main }
opt.parse(ARGV)

no_command_main if ARGV == []
