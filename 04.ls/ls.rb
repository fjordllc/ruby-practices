require 'debug'

def ls_v1
  all_file = Dir.glob('*').sort
  div = all_file.size / 3
  amari = all_file.size % 3
  total_row = (amari == 0) ? div : (div + 1)
  width = all_file.max { |a, b| a.length <=> b.length }.size + 7
  all_sort_file = all_file.each_slice(3).to_a
  0.upto(total_row - 1) do |idx|
    3.times do |time|
      print all_sort_file[idx][time].ljust(width)
    end
    puts
  end
end



def ls_v2
  all_file = Dir.glob('*').sort
  div = all_file.size / 3
  amari = all_file.size % 3
  total_row = (amari == 0) ? div : (div + 1)
  width = all_file.max { |a, b| a.length <=> b.length }.size + 7

  grouped_files = all_file.map.with_index do |file, idx|
    [idx % 3, file]
  end.sort.each_slice(3).to_a
  total_row.times do |row|
    3.times do |col|
      print grouped_files[row][col][1].ljust(width)
    end
    puts
  end
end

ls_v2
