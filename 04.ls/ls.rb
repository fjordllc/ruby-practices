# frozen_string_literal: true

def pad_files(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  files.map { |file| file.ljust(max_length) }
       .each_slice(rows).to_a
end

def distribute_files(files, cols)
  pad_files(files, cols)
end

def list_directory
  file_names = Dir.glob('*').sort

  cols = 3

  padded_files = distribute_files(file_names, cols)
  padded_files[0].zip(*padded_files[1..]).each do |row|
    puts row.join('  ')
  end
end

list_directory
