# frozen_string_literal: true

CURRENT_PATH = ARGV[0].nil? ? __dir__ : ARGV[0]
MARGIN = 3

def add_spacing(filename)
  filename.ljust(COLUMN_SPACING + MARGIN)
end

def formatted_print(ordered_file_list)
  0.upto(ROW_COUNT - 1) do |index|
    first_column = ordered_file_list[0][index]
    second_column = ordered_file_list[1][index].nil? ? ' ' : ordered_file_list[1][index]
    third_column = ordered_file_list[2][index].nil? ? ' ' : ordered_file_list[2][index]

    print(add_spacing(first_column) + add_spacing(second_column) + third_column)
    puts('')
  end
end

file_list = Dir.glob("#{CURRENT_PATH}/*")
file_count = file_list.length
ROW_COUNT = (file_count / 3.to_f).ceil

max_length = 0
ordered_file_list = []
current_column = 0

file_list.each_with_index do |file_path, index|
  if (index % ROW_COUNT).zero? || index.zero?
    ordered_file_list.append([])
    current_column += 1 if index.positive?
  end
  file_name = File.basename(file_path)
  max_length = file_name.length if file_name.length > max_length
  ordered_file_list[current_column].append(file_name)
end

COLUMN_SPACING = max_length
formatted_print(ordered_file_list)
