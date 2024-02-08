# frozen_string_literal: true

MAX_COLUMNS = 3

def partition_filenames(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  partitioned_files = files.map { |file| file.ljust(max_length) }
  if files.length == 4
    return [
      partitioned_files[0..1],
      [partitioned_files[2], nil],
      [partitioned_files[3], nil]
    ]
  end

  partitioned_files.each_slice(rows).to_a
end

def list_directory(include_hidden: false)
  file_names = include_hidden ? Dir.glob('{*,.*}') : Dir.glob('*')
  partitioned_files = partition_filenames(file_names, MAX_COLUMNS)
  partitioned_files[0].zip(*partitioned_files[1..]).each do |row|
    puts row.join('  ')
  end
end

include_hidden = ARGV.include?('-a')
list_directory(include_hidden:)
