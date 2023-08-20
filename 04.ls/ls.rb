require 'debug'

initial_row = 3

def parse_file(initial_row)
  all_file = Dir.glob('*').sort
  div, mod = all_file.size.divmod(initial_row)
  total_row = (mod == 0) ? div : (div + 1)
  width = all_file.max { |a, b| a.length <=> b.length }.size + 7
  [all_file, total_row, width]
end

all_file, total_row, width = parse_file(initial_row)

def ls_v1(initial_row, all_file, total_row, width)
  all_sort_file = all_file.each_slice(total_row).to_a
  total_row.times do |col|
    initial_row.times do |row|
      file_name = all_sort_file[row][col]
      print file_name.ljust(width) unless file_name.nil?
      binding.break
    end
    puts
  end
end

ls_v1(initial_row, all_file, total_row, width)

def ls_v2(initial_row, all_file, total_row, width)
  grouped_files = all_file.map.with_index do |file, idx|
    [idx % total_row, file]
  end.group_by { |div, file| div }
  total_row.times do |row|
    initial_row.times do |col|
      file_name = grouped_files[row][col]
      print file_name[1].ljust(width) unless file_name.nil?
    end
    puts
  end
end

ls_v2(initial_row, all_file, total_row, width)
