#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN_COUNT = 3
COLUMN_MARGIN = 4

FILE_TYPE = {
  'file' => '-',
  'directory' => 'd',
  'link' => 'l'
}.freeze

FILE_PERMISSION = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def main
  options = {}
  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  opt.on('-l') { |v| options[:l] = v }
  path = opt.parse(ARGV)[0]

  puts ls(options, path)
end

def ls(options, path = '.')
  files = get_files(options, path)
  return '' if files.empty?

  if options[:l]
    long_data = get_long_data(files, path)
    format_long(long_data)
  else
    columns = slice_columns(files)
    format_columns(files, columns)
  end
end

def get_files(options, path)
  glob_flag = options[:a] ? File::FNM_DOTMATCH : 0
  files = Dir.glob('*', glob_flag, base: path).sort
  files = files.reverse if options[:r]
  files
end

def slice_columns(files)
  row_count = (files.size / COLUMN_COUNT.to_f).ceil
  files.each_slice(row_count).map do |f|
    f.fill('', f.size, row_count - f.size)
  end
end

def format_columns(files, columns)
  column_width = files.max_by(&:length).length + COLUMN_MARGIN
  columns.transpose.map do |column|
    column.map { |f| f.ljust(column_width) }.join
  end
end

def get_long_data(files, path)
  long_data = []
  files.each do |filename|
    data = {}
    filepath = "#{path}/#{filename}"
    fs = if File.ftype(filepath) == 'link'
           File.lstat(filepath)
         else
           File::Stat.new(filepath)
         end
    data[:filetype] = FILE_TYPE[fs.ftype]
    mode = fs.mode.to_s(8)
    permission = ''
    (-3..-1).each do |index|
      permission += FILE_PERMISSION[mode[index]]
    end
    data[:permission] = permission
    data[:link] = fs.nlink
    data[:owner_name] = Etc.getpwuid(File.stat(filepath).uid).name
    data[:group_name] = Etc.getgrgid(File.stat(filepath).gid).name
    data[:byte_size] = fs.size
    data[:timestamp] = fs.mtime.strftime('%_2m %e %H:%M')
    data[:filename] = filename
    data[:filename] += " -> #{File.readlink(filepath)}" if File.ftype(filepath) == 'link'
    data[:blocks] = fs.blocks
    long_data << data
  end
  long_data
end

def format_long(long_data)
  rows = []
  rows << "total #{long_data.sum { |x| x[:blocks] }}"
  long_data.each do |data|
    row = []
    row << (data[:filetype] + data[:permission])
    row << data[:link].to_s.rjust(get_max_length(long_data, :link) + 1)
    row << data[:owner_name].to_s.rjust(get_max_length(long_data, :owner_name))
    row << data[:group_name].to_s.rjust(get_max_length(long_data, :group_name))
    row << data[:byte_size].to_s.rjust(get_max_length(long_data, :byte_size) + 1)
    row << data[:timestamp]
    row << data[:filename]
    rows << row.join(' ')
  end
  rows
end

def get_max_length(long_data, key)
  data = long_data.max_by do |x|
    x[key].to_s.length
  end
  data[key].to_s.length
end

main
