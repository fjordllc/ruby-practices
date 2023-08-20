# frozen_string_literal: true

def parse_file
  Dir.glob('*').sort
end

def calculate_row_and_space(initial_row, all_files)
  div, mod = all_files.size.divmod(initial_row)
  total_row = mod.zero? ? div : (div + 1)
  width = all_files.max_by(&:length).length + 7
  [total_row, width]
end

initial_row = 3
all_files = parse_file
total_row, width = calculate_row_and_space(initial_row, all_files)
argument = {
  initial_row: 3,
  all_files: parse_file,
  total_row:,
  width:
}

def ls_v1(initial_row:, all_files:, total_row:, width:)
  all_sort_files = all_files.each_slice(total_row).to_a
  total_row.times do |col|
    initial_row.times do |row|
      file_name = all_sort_files[row][col]
      print file_name.ljust(width) unless file_name.nil?
    end
    puts
  end
end

def ls_v2(initial_row:, all_files:, total_row:, width:)
  grouped_files = all_files.map.with_index do |file, idx|
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

puts "ls_v1の結果"
ls_v1(**argument)
puts "ls_v2の結果"
ls_v2(**argument)
