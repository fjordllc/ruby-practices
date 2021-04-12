# frozen_string_literal: true

require 'etc'
require 'optparse'

MAX_COLUMN_COUNT = 3

FILE_TYPES = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's'
}.freeze

FILE_PERMISSIONS = {
  '7' => 'rwx',
  '6' => 'rw-',
  '5' => 'r-x',
  '4' => 'r--',
  '3' => '-wx',
  '2' => '-w-',
  '1' => '--x',
  '0' => '---'
}.freeze

def main
  options = ARGV.getopts('a', 'l', 'r')

  path_list = ARGV
  path_list.push '.' if path_list.empty?

  path_list.each do |path|
    file_names = get_file_names(path, option_a: options['a'], option_r: options['r'])

    puts "\n" if path_list.size > 1

    if options['l']
      file_info_table = file_names.to_h { |file| [file, get_file_info(path, file)] }
      output_with_l_option(file_info_table)
    else
      output(file_names)
    end
  end
end

def get_file_names(path, option_a: false, option_r: false)
  return [path] if File.file?(path)

  list_file = option_a ? Dir.glob('*', File::FNM_DOTMATCH, base: path) : Dir.glob('*', base: path)
  list_file.sort!

  option_r ? list_file.reverse : list_file
end

def get_file_info(path, file_name)
  file_path = path == file_name ? file_name : "#{path}/#{file_name}"

  fs = File::Stat.new(file_path)

  type = FILE_TYPES[fs.ftype]
  mode = convert_permission(fs.mode.to_s(8).to_i % 1000)
  size = fs.size
  nlink = fs.nlink

  date_time = fs.mtime.localtime
  month = date_time.strftime('%b')
  day = date_time.day
  time = date_time.strftime('%H:%M')

  uid = Etc.getpwuid(fs.uid).name
  gid = Etc.getgrgid(fs.gid).name

  block = fs.blocks

  [type + mode, nlink, uid, gid, size, month, day, time, block]
end

def convert_permission(number)
  number.to_s.chars.map { |char| FILE_PERMISSIONS[char] }.join
end

def output(file_names)
  row_count, rem = file_names.size.divmod(MAX_COLUMN_COUNT)
  row_count += 1 unless rem.zero?

  max_name_length = file_names.max(1) { |a, b| a.size <=> b.size }.join.size

  matrix = Array.new(row_count) { [] }
  file_names.each_with_index do |item, index|
    matrix[index % row_count] << item
  end

  matrix.each_index do |row_index|
    column_count = matrix[row_index].size
    format_str = "%-#{max_name_length}s " * column_count
    puts format(format_str, *matrix[row_index])
  end
end

def output_with_l_option(file_info_table)
  file_attribute_count = 0
  file_info_table.each_value do |file_info|
    file_attribute_count = file_info.size
  end

  max_length_list = Array.new(file_attribute_count) { 0 }

  file_info_table.each_value do |file_info|
    file_info.each_with_index do |item, index|
      item_size = item.to_s.size
      max_length_list[index] = item_size if max_length_list[index] < item_size
    end
  end

  block_index = 8
  total = file_info_table.each_value.sum { |file_info| file_info[block_index] }
  puts "total #{total}"

  range_type_to_time = 0..7
  format_str = "%#{max_length_list.slice(range_type_to_time).join('s %')}s %s"
  file_info_table.each do |file_name, file_info|
    puts format(format_str, *file_info.slice(range_type_to_time), file_name)
  end
end

main
