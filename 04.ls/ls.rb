# frozen_string_literal: true

def distribute_files(files, cols)
  rows = (files.length / cols.to_f).ceil
  files.each_slice(rows).to_a
end

def list_directory
  file_names = Dir.glob('*').sort
  file_count = file_names.size

  cols = if file_count <= 3
           file_count
         else
           3
         end

  padded_files = distribute_files(file_names, cols)
  p padded_files
  padded_files[0].zip(*padded_files[1..]).each do |row|
    puts row.join('  ')
  end
end

list_directory
