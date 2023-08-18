
all_file = Dir.glob('*')
div = all_file.size / 3
amari = all_file.size % 3
total_row = (amari == 0) ? div : (div + 1)
max_length = all_file.max { |a, b| a.length <=> b.length }.size
all_sort_file = all_file.each_slice(3).to_a.sort
p all_sort_file
