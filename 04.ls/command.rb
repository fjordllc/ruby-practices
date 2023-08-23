# frozen_string_literal: true

current_path = ARGV[0].nil? ? __dir__ : ARGV[0]
MARGIN = 3

def get_column_spacing(file_list)
  file_list.max_by(&:length).length + MARGIN
end

file_list = Dir.glob("#{current_path}/*").collect! { |file_path| File.basename(file_path) }
file_count = file_list.length
row_count = (file_count / 3.to_f).ceil
column_spacing = get_column_spacing(file_list)

0.upto(row_count - 1) do |index|
  print(File.basename(file_list[index]).ljust(column_spacing))
  row_count + index <= file_count - 1 ? print(File.basename(file_list[row_count + index]).ljust(column_spacing)) : print(' '.ljust(column_spacing))
  row_count * 2 + index <= file_count - 1 ? print(File.basename(file_list[row_count * 2 + index])) : print(' ')
  puts ''
end

puts ''
