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
  flags = options[:include_hidden] ? File::FNM_DOTMATCH : 0
  file_names = Dir.glob('*', flags)
  file_names.reverse! if options[:reverse]
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

opt.on('-r') do
  options[:reverse] = true
end

opt.parse!(ARGV)

list_directory(options)
