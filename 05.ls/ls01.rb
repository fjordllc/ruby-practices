# frozen_string_literal: true

def main
  current_files = Dir.glob('*').sort
  row_num = 3
  current_column_num = get_current_columns(current_files,row_num)
  # transposed_to_display = transposed_files(current_column_num)
  p current_files
  p current_column_num
end

def get_current_columns(current_files,row_num)
  current_files << " " while current_files.length % row_num != 0
  current_files.length / row_num
end

# def transposed_files(colu)
#   transposed_files = current_files.each_slice(column_num).to_a.transpose

#   transposed_files.first(column_num).each do |each_column|
#     row_num.times do |index|
#     each_column[index] += ' ' * (24 - each_column[index].length)
#     end
#   end

# end

main
# def join_file()
#   transposed_files.each do |displayed_files|
#     puts displayed_files.join
#   end
# end

#   main