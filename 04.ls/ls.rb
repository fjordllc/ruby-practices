require 'debug'
def parse_file
  all_file = Dir.glob('*').sort
  div = all_file.size / 3
  amari = all_file.size % 3
  total_row = (amari == 0) ? div : (div + 1)
  width = all_file.max { |a, b| a.length <=> b.length }.size + 7
  [all_file, total_row, width]
end

all_file, total_row, width = parse_file

def ls_v1(all_file, total_row, width)
  all_sort_file = all_file.each_slice(5).to_a
  total_row.times do |col|
    3.times do |row|
      file_name = all_sort_file[row][col]
      print file_name.ljust(width) unless file_name.nil?
    end
    puts
  end
end

ls_v1(all_file, total_row, width)

def ls_v2(all_file, total_row, width)
  grouped_files = all_file.map.with_index do |file, idx|
    [idx % total_row, file]
  end.group_by { |div, file| div }
  total_row.times do |row|
    3.times do |col|
      file_name = grouped_files[row][col]
      print file_name[1].ljust(width) unless file_name.nil?
    end
    puts
  end
end

ls_v2(all_file, total_row, width)
