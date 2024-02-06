# frozen_string_literal: true

COLS = 3

def distribute_files(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  files.map { |file| file.ljust(max_length) }
       .each_slice(rows).to_a
end

def list_directory
  file_names = Dir.glob('*')

  padded_files = distribute_files(file_names, COLS)
  padded_files[0].zip(*padded_files[1..]).each do |row|
    puts row.join('  ')
  end
end

list_directory
