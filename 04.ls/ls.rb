# frozen_string_literal: true

require 'optparse'
require 'etc'

MAX_COLUMNS = 3
FILE_TYPE_CHARACTORS = { '10': '-', '04': 'd', '12': 'l', '02': 'c', '06': 'b', '01': 'p', '14': 's' }.freeze
PERMISSIONS = { '0': '---', '1': '--x', '2': '-w-', '3': '-wx', '4': 'r--', '5': 'r-x', '6': 'rw-', '7': 'rwx' }.freeze

def partition_filenames(files, cols)
  rows = (files.length / cols.to_f).ceil
  max_length = files.max_by(&:length).length
  partitioned_files = files.map { |file| file.ljust(max_length) }

  partitioned_files.each_slice(rows).to_a
end

def format_mode(mode)
  mode_str = mode.rjust(6, '0')
  type_code = mode_str[0..1]
  file_types = FILE_TYPE_CHARACTORS[type_code.to_sym] || '-'
  user_permissions, group_permissions, other_permissions = mode_str[3..5].chars.map { |char| PERMISSIONS[char.to_sym] }
  "#{file_types}#{user_permissions}#{group_permissions}#{other_permissions}"
end

def format_file_stat(file)
  stat = File.stat(file)
  mode = format_mode(stat.mode.to_s(8))
  link_count = stat.nlink
  owner_name = Etc.getpwuid(stat.uid).name
  group_name = Etc.getgrgid(stat.gid).name
  size = stat.size
  mtime = stat.mtime.strftime('%-m %e %H:%M')
  "#{mode} #{link_count} #{owner_name} #{group_name.rjust(5)} #{size.to_s.rjust(4)} #{mtime} #{file}"
end

def list_directory(options)
  flags = options[:include_hidden] ? File::FNM_DOTMATCH : 0
  file_names = Dir.glob('*', flags)
  file_names.reverse! if options[:reverse]

  if options[:long_format]
    total_size = file_names.sum { |file| File.stat(file).blocks }
    puts "total #{total_size}"
    file_names.each do |file|
      puts format_file_stat(file)
    end
  else
    partitioned_files = partition_filenames(file_names, MAX_COLUMNS)
    partitioned_files[0].zip(*partitioned_files[1..]).each do |row|
      puts row.join('  ')
    end
  end
end

options = { include_hidden: false, reverse: false, long_format: false }
opt = OptionParser.new

opt.on('-a') do
  options[:include_hidden] = true
end

opt.on('-r') do
  options[:reverse] = true
end

opt.on('-l') do
  options[:long_format] = true
end

opt.parse!(ARGV)

list_directory(options)
