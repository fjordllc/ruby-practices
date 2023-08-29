# frozen_string_literal: true

current_path = ARGV[0].nil? ? __dir__ : ARGV[0]
MARGIN = 3

def add_spacing(filename, column_spacing)
  filename.ljust(column_spacing + MARGIN)
end

def formatted_print(ordered_file_list, column_spacing, row_count)
  row_count.times do |row_index|
    3.times do |column_index|
      formatted_row = ordered_file_list[column_index][row_index].nil? ? ' ' : ordered_file_list[column_index][row_index]
      print(add_spacing(formatted_row, column_spacing))
    end
    puts('')
  end
end

file_list = Dir.glob("#{current_path}/*")
file_count = file_list.length
row_count = (file_count / 3.to_f).ceil

max_length = 0
ordered_file_list = [] << []

file_list.each_with_index do |file_path, index|
  ordered_file_list << [] if (index % row_count).zero?
  file_name = File.basename(file_path)
  max_length = file_name.length if file_name.length > max_length
  ordered_file_list[index / row_count].append(file_name)
end

formatted_print(ordered_file_list, max_length, row_count)
