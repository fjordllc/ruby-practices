#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COL_MAX = 3
PADDING = 2
FILE_TYPE_TO_CHARACTER = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's',
  'unknown' => '?'
}.freeze
PERMISSION_SEPARATOR = 512

def main
  options = { l: false }
  opt = OptionParser.new
  opt.on('-l') { options[:l] = true }
  argv = opt.parse(ARGV)

  path = argv[0] || './'
  FileTest.directory?(path) or return
  file_names = Dir.children(path).sort
  filtered_file_names = file_names.reject { |name| name.start_with?('.') }
  options[:l] ? display_file_names_with_long(path, filtered_file_names) : display_file_names(filtered_file_names)
end

def display_file_names_with_long(path, file_names)
  file_paths = file_names.map { |file_name| File.join(path, file_name) }
  total_block_size = file_paths.sum { |file_path| File.stat(file_path).blocks }
  puts "total #{total_block_size / 2}"

  file_paths.each do |file_path|
    file_type = File.ftype(file_path)
    stat = File.stat(file_path)
    mode_number = stat.mode % PERMISSION_SEPARATOR
    mode = convert_mode_number_to_mode(mode_number)
    column_name_to_width = get_column_name_to_width(file_paths)
    print FILE_TYPE_TO_CHARACTER[file_type]
    print "#{mode} "
    print "#{stat.nlink.to_s.rjust(column_name_to_width[:hard_link_number])} "
    print "#{Etc.getpwuid(stat.uid).name.rjust(column_name_to_width[:owner_name])} "
    print "#{Etc.getgrgid(stat.gid).name.rjust(column_name_to_width[:group_name])} "
    print "#{stat.size.to_s.rjust(column_name_to_width[:byte_size])} "
    print "#{stat.mtime.strftime('%b %e %H:%M')} "
    puts File.basename(file_path)
  end
end

def get_column_name_to_width(file_paths)
  column_name_to_width = { hard_link_number: 0, owner_name: 0, group_name: 0, byte_size: 0 }
  file_paths.each do |file_path|
    stat = File.stat(file_path)
    column_name_to_width[:hard_link_number] = [column_name_to_width[:hard_link_number], stat.nlink.to_s.length].max
    column_name_to_width[:owner_name] = [column_name_to_width[:owner_name], Etc.getpwuid(stat.uid).name.length].max
    column_name_to_width[:group_name] = [column_name_to_width[:group_name], Etc.getgrgid(stat.gid).name.length].max
    column_name_to_width[:byte_size] = [column_name_to_width[:byte_size], stat.size.to_s.length].max
  end
  column_name_to_width
end

def convert_mode_number_to_mode(mode_number)
  mode = ''
  binary_modes = mode_number.digits(2).reverse
  binary_modes.each.with_index do |binary_mode, index|
    case index % 3
    when 0 then mode += binary_mode == 1 ? 'r' : '-'
    when 1 then mode += binary_mode == 1 ? 'w' : '-'
    when 2 then mode += binary_mode == 1 ? 'x' : '-'
    end
  end
  mode
end

def display_file_names(file_names)
  total_file_names = file_names.size.to_f
  row_size = (total_file_names / COL_MAX).ceil
  col_size = (total_file_names / row_size).ceil
  widths = get_column_widths(file_names, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = file_names[row + col * row_size]
      width = widths[col] + PADDING
      print file_name.ljust(width, ' ') if file_name
    end
    puts
  end
end

def get_column_widths(file_names, row_size, col_size)
  widths = Array.new(col_size, 0)
  file_names.each.with_index do |file_name, index|
    column_index = index / row_size
    widths[column_index] = file_name.length if file_name.length > widths[column_index]
  end
  widths
end

main
