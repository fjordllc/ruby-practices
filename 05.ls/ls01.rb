# frozen_string_literal: true

ROW_NUM = 3
COLUMN_WIDTH = 24
ALL_FILES = Dir.glob('*').sort

def main
  column_num = ALL_FILES.length / ROW_NUM
  files = get_transposed_all_files(column_num)
  display(files)
end

def get_transposed_all_files(column_num)
  ALL_FILES.push(' ') while ALL_FILES.length % ROW_NUM != 0
  transposed_files = ALL_FILES.each_slice(column_num).to_a.transpose
  transposed_files.first(column_num).each do |each_column|
    ROW_NUM.times do |index|
      each_column[index] += ' ' * (COLUMN_WIDTH - each_column[index].length)
    end
  end
end

def display(files)
  files.each do |each_files|
    puts each_files.join
  end
end

main
