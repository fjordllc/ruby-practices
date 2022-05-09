# frozen_string_literal: true
aaa
require 'optparse'

ROW_NUM = 3
ROW_MAX_WIDTH = 24

def main
  all_files = acquire_all_files
  files_in_columns = get_transposed_all_files(all_files)
  display(files_in_columns)
end

def acquire_all_files
  opt = OptionParser.new
  opt.on('-a')
  opt.parse(ARGV)
  if ARGV == ['-a']
    Dir.glob('*', File::FNM_DOTMATCH).sort
  else
    Dir.glob('*').sort
  end
end


def get_transposed_all_files(all_files)
  all_files.push(' ') while all_files.length % ROW_NUM != 0
  column_num = all_files.length / ROW_NUM
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

main
