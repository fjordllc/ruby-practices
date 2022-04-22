# frozen_string_literal: true

def main
  row_num = 3
  all_files = get_all_files(row_num)
  column_num = all_files.length / row_num
  transposed_all_files = get_transposed_all_files(row_num, all_files, column_num)
  files_to_display(transposed_all_files)
end

def get_all_files(row_num)
  files = Dir.glob('*').sort
  new_files = files.push(' ') while files.length % row_num != 0
  new_files
end

def get_transposed_all_files(row_num, all_files, column_num)
  transposed_files = all_files.each_slice(column_num).to_a.transpose
  transposed_files.first(column_num).each do |each_column|
    row_num.times do |index|
      each_column[index] += ' ' * (24 - each_column[index].length)
    end
  end
end

def files_to_display(transposed_all_files)
  transposed_all_files.each do |transposed_each_files|
    puts transposed_each_files.join
  end
end

main
