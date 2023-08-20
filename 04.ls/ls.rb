# frozen_string_literal: true

def parse_file
  Dir.glob('*').sort
end

def calculate_row_and_space(initial_row, all_file)
  div, mod = all_file.size.divmod(initial_row)
  total_row = mod.zero? ? div : (div + 1)
  width = all_file.max_by(&:length).length + 7
  [total_row, width]
end

initial_row = 3
all_file = parse_file
total_row, width = calculate_row_and_space(initial_row, all_file)
argument = {
  initial_row: 3,
  all_file: parse_file,
  total_row: total_row,
  width: width
}

def ls_v1(initial_row:, all_file:, total_row:, width:)
  all_sort_file = all_file.each_slice(total_row).to_a
  total_row.times do |col|
    initial_row.times do |row|
      file_name = all_sort_file[row][col]
      print file_name.ljust(width) unless file_name.nil?
    end
    puts
  end
end

def ls_v2(initial_row:, all_file:, total_row:, width:)
  grouped_files = all_file.map.with_index do |file, idx|
    [idx % total_row, file]
  end
  grouped_files = grouped_files.group_by { |div, _| div }
  total_row.times do |row|
    initial_row.times do |col|
      file_name = grouped_files[row][col]
      print file_name[1].ljust(width) unless file_name.nil?
    end
    puts
  end
end

ls_v1(**argument)
ls_v2(**argument)
