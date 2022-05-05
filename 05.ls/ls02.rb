# frozen_string_literal: true

require 'optparse'

ROW_NUM = 3
ROW_MAX_WIDTH = 24

def no_option
  all_files = Dir.glob('*').sort
  main(all_files)
end

def a_option
  all_files = Dir.glob('*', File::FNM_DOTMATCH).sort
  main(all_files)
end

def main(all_files)
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
opt.on('-a') { a_option }
opt.parse(ARGV)
no_option if ARGV == []
