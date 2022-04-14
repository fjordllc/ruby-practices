current_files = Dir.glob('*').sort
row_num = 3

def add_blank(receive_blank)
  receive_blank << ' '
end

add_blank(current_files) while current_files.length % row_num != 0
column_num = current_files.length / row_num

transposed_files = current_files.each_slice(column_num).to_a.transpose

transposed_files.first(column_num).each do |each_column|
  row_num.times do |index|
    each_column[index] << ' ' * (24 - each_column[index].length)
  end
end

transposed_files.each do |displayed_files|
  def join(each_transposed_file)
    puts each_transposed_file.join
  end
  join(displayed_files)
end