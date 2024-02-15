# frozen_string_literal: true

require 'optparse'

MAX_COLUMNS = 3

def partition_filenames(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  partitioned_files = files.map { |file| file.ljust(max_length) }

  partitioned_files.each_slice(rows).to_a
end

def list_directory(options)
  file_names = options[:include_hidden] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  partitioned_files = partition_filenames(file_names, MAX_COLUMNS)
  partitioned_files[0].zip(*partitioned_files[1..]).each do |row|
    puts row.join('  ')
  end
end

options = { include_hidden: false, reverse: false }
opt = OptionParser.new

opt.on('-a') do
  options[:include_hidden] = true
end
opt.parse!(ARGV)

list_directory(options)
