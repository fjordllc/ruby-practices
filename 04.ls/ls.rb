# frozen_string_literal: true

MAX_COLMNS = 3

def partition_filenames(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  files.map { |file| file.ljust(max_length) }
       .each_slice(rows).to_a
end

def list_directory
  file_names = Dir.glob('*')

  partitioned_files = partition_filenames(file_names, MAX_COLMNS)
  partitioned_files[0].zip(*partitioned_files[1..]).each do |row|
    puts row.join('  ')
  end
end

list_directory
