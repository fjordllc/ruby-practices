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

ls_v1
