#argument = ['../']
argument = ARGV
argument.push(Dir.pwd) if argument.size < 1

#step1
  #1filesname = [file1, file2, file3, file4]
  #'+ 5'はlsコマンドと幅が一緒なため付与

#step2
  #filesname = [file1, file2, file3, nil, file4, nil]
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
  padding = filesname.map(&:size).max + 5
  case count_files_mod_by_three
  when 1
    filesname.insert(the_end_of_second_column_index, nil)
    filesname.insert(the_end_of_third_column_index, nil)
  when 2
    filesname.insert(the_end_of_third_column_index, nil)
  else
    filesname
  end
  devide_files_by_columns(max_line_length, padding, filesname)
end
#step3
  #filesname = [[file1, file2], [file3, nil], [file4, nil]]
def devide_files_by_columns(max_line_length, padding, filesname)
  devide_files_by_column = filesname.each_slice(max_line_length).to_a
  transpose_files_devided(devide_files_by_column, padding)
end

#step4
  #filesname = [[file1, file3, file4], [file2, nil, nil]]
def transpose_files_devided(devide_files_by_column, padding)
  create_file_matrix = devide_files_by_column.transpose
  output(create_file_matrix, padding)
end

#step5
  #標準出力に出力
def output(create_file_matrix, padding) 
  create_file_matrix.each do |file_line|
    puts file_line.compact.join(' ')
  end
end

argument.each do |directory|
  filesname = Dir.glob('*', base: directory)
  get_number_of_count_files_mod_by_three(filesname)
end