# frozen_string_literal: true

def relocate_elements(files)
  duplicated_files = files.map(&:dup)
  while duplicated_files.any?(&:empty?)
    empty_list_index = duplicated_files.each_index.select { |i| duplicated_files[i].empty? }.reverse
    empty_list_index.each do |empty_index|
      left_list_index = empty_index - 1
      if duplicated_files[left_list_index].length > 1
        duplicated_files[empty_index] << duplicated_files[left_list_index].pop
      elsif duplicated_files[left_list_index].length == 1
        duplicated_files[empty_index] = duplicated_files[left_list_index]
        duplicated_files[left_list_index] = []
      end
    end
  end
  duplicated_files
end

def pad_files(padded_files)
  max_length = padded_files.map(&:length).max
  padded_files.map { |column| column + [nil] * (max_length - column.length) }
end

def distribute_files(files, cols)
  col_length = (files.length / cols.to_f).ceil
  padded_files = files.each_slice(col_length).to_a
  if files.length / cols <= 1 && cols < files.length
    padded_files = Array.new(cols) { [] }
    files.each_with_index do |file, index|
      sublist_index = index / 2
      break if sublist_index >= cols

      padded_files[sublist_index] << file
    end
    padded_files = relocate_elements(padded_files)
  else
    padded_files = pad_files(padded_files)
  end
  padded_files
end

def calculate_columns(max_name_length, screen_width)
  screen_width / (max_name_length + 2)
end

def list_directory
  file_names = Dir.glob('*')
  max_file_name_length = file_names.map(&:length).max
  screen_width = `tput cols`.to_i

  cols = calculate_columns(max_file_name_length, screen_width) > 3 ? 3 : calculate_columns(max_file_name_length, screen_width)
  padded_files = distribute_files(file_names, cols)
  padded_files[0].zip(*padded_files[1...]).each do |row|
    puts row.map(&:to_s).join('  ')
  end
end

list_directory
