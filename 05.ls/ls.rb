# frozen_string_literal: true

COLUMN_COUNT = 3.0
CURRENT_DIRECTORY_FILES = Dir.glob('*')

def calc_file_count_per_column(files, column_count)
  (files.size / column_count).ceil
end

def build_display_column
  file_count_per_column = calc_file_count_per_column(CURRENT_DIRECTORY_FILES, COLUMN_COUNT)

  devided_file_list = []
  CURRENT_DIRECTORY_FILES.each_slice(file_count_per_column) { |file| devided_file_list << file }

  adjusted_file_list = []
  devided_file_list.each do |column|
    max_str_count = column.max_by(&:size).size
    adjusted_file_list << column.map { |v| v.ljust(max_str_count + 2) }
  end

  last_column = adjusted_file_list.last
  if last_column.size != file_count_per_column
    empty_column_data_size = file_count_per_column - last_column.size
    count = 0
    while count < empty_column_data_size
      last_column << ''
      count += 1
    end
  end
  adjusted_file_list.flatten
end

def display_files
  file_count_per_column = calc_file_count_per_column(CURRENT_DIRECTORY_FILES, COLUMN_COUNT)
  (0...file_count_per_column).each do |n|
    row = build_display_column.select.with_index { |_, i| i % file_count_per_column == n }
    row.each.with_index { |row_data, i| print i % 3 == 2 ? "#{row_data}\n" : row_data }
  end
end

display_files
