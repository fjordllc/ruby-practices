# frozen_string_literal: true

def relocate_elements(files)
  relocated_files = files.map(&:dup)  # 配列の複製を作成
  while relocated_files.any?(&:empty?)
    empty_list_index = relocated_files.each_index.select { |i| relocated_files[i].empty? }.reverse
    empty_list_index.each do |empty_index|
      left_list_index = empty_index - 1
      if relocated_files[left_list_index].length > 1
        relocated_files[empty_index] << relocated_files[left_list_index].pop
      elsif relocated_files[left_list_index].length == 1
        relocated_files[empty_index] = relocated_files[left_list_index]
        relocated_files[left_list_index] = []
      end
    end
  end
  relocated_files
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

def list_directory(cols = 2)
  file_names = Dir.glob('*')
  padded_files = distribute_files(file_names, cols)
  padded_files[0].zip(*padded_files[1...]).each do |row|
    puts row.map(&:to_s).join('  ')
  end
end

list_directory
