argument = ARGV
argument.push(Dir.pwd) if argument.size < 1

def get_number_of_count_files_mod_by_three(filesname)
  max_column_length = 3
  count_files = filesname.count
  count_files_mod_by_three = count_files % max_column_length
  get_max_line_length(count_files_mod_by_three, count_files, max_column_length, filesname)
end

def get_max_line_length(count_files_mod_by_three, count_files, max_column_length, filesname)
  max_line_length = if count_files_mod_by_three == 0
    count_files / max_column_length
  else
    (count_files / max_column_length).next
  end
  decide_position_of_nil(max_line_length, filesname, count_files_mod_by_three)
end

def decide_position_of_nil(max_line_length, filesname, count_files_mod_by_three)
  the_end_of_second_column_index = (max_line_length * 2).pred
  the_end_of_third_column_index = (max_line_length * 3).pred
  completement_with_nil(the_end_of_second_column_index, the_end_of_third_column_index, filesname, max_line_length, count_files_mod_by_three)
end

def completement_with_nil(the_end_of_second_column_index, the_end_of_third_column_index, filesname, max_line_length, count_files_mod_by_three)
  case count_files_mod_by_three
  when 1
    filesname.insert(the_end_of_second_column_index, nil)
    filesname.insert(the_end_of_third_column_index, nil)
  when 2
    filesname.insert(the_end_of_third_column_index, nil)
  else
    filesname
  end
  devide_files_by_columns(max_line_length, filesname)
end

def devide_files_by_columns(max_line_length, filesname)
  devide_files_by_column = filesname.each_slice(max_line_length).to_a
  transpose_files_devided(devide_files_by_column,)
end

def transpose_files_devided(devide_files_by_column)
  create_file_matrix = devide_files_by_column.transpose
  output(create_file_matrix)
end

def output(create_file_matrix) 
  create_file_matrix.each do |file_line|
    puts file_line.compact.join('  ')
  end
end

argument.each.with_index do |directory, index|
  puts directory if index > 0
  filesname = Dir.glob('*', base: directory)
  get_number_of_count_files_mod_by_three(filesname)
end