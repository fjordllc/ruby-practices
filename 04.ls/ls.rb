# frozen_string_literal: true

def relocate_elements(files)
  while files.any?(&:empty?)
    empty_list_index = files.each_index.select { |i| files[i].empty? }.reverse
    empty_list_index.each do |empty_index|
      left_list_index = empty_index - 1
      if files[left_list_index].length > 1
        files[empty_index] << files[left_list_index].pop
      elsif files[left_list_index].length == 1
        files[empty_index] = files[left_list_index]
        files[left_list_index] = []
      end
    end
  end
  files
end

def pad_files(padded_files)
  max_length = padded_files.map(&:length).max
  padded_files.map! { |column| column + [nil] * (max_length - column.length) }
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
  end
  pad_files(padded_files)
end

def list_directory(cols = 3)
  files = Dir.glob('*', File::FNM_DOTMATCH)
  padded_files = distribute_files(files, cols)
  padded_files[0].zip(*padded_files[1...]).each do |row|
    puts row.map(&:to_s).join('  ')
  end
end

list_directory
