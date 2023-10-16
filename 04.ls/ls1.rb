# frozen_string_literal: true

def list_files_in_columns(columns = 3)
  current_path = Dir.pwd 
  folder_glob = "#{current_path}/*"

  files = Dir.glob(folder_glob)

  max_length = files.map { |file| File.basename(file).length }.max || 0

  column_width = (max_length + 2)

  (files.length.to_f / columns).ceil

  column_arrays = Array.new(columns) { [] }

  files.each_with_index do |file, index|
    column_arrays[index % columns] << File.basename(file)
  end

  column_arrays.each do |row|
    columns.times do |col|
    end
    puts
  end
end

list_files_in_columns
