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
      file_info_table = file_names.to_h { |file_name| [file_name, get_file_info(path, file_name)] }
      output_with_l_option(file_info_table)
    else
      output(file_names)
    end
  end
end

def get_file_names(path, option_a: false, option_r: false)
  return [path] if File.file?(path)

  file_names = option_a ? Dir.glob('*', File::FNM_DOTMATCH, base: path) : Dir.glob('*', base: path)
  file_names.sort!

  option_r ? file_names.reverse : file_names
end

def get_file_info(path, file_name)
  file_path = path == file_name ? file_name : "#{path}/#{file_name}"

  file_stat = File::Stat.new(file_path)
  type = FILE_TYPES[file_stat.ftype]
  mode_integer = file_stat.mode.to_s(8).to_i % 1000
  mode = mode_integer.to_s.chars.map { |char| FILE_PERMISSIONS[char] }.join
  date_time = file_stat.mtime.localtime

  {
    type_mode: type + mode,
    nlink: file_stat.nlink,
    block: file_stat.blocks,
    size: file_stat.size,
    uid: Etc.getpwuid(file_stat.uid).name,
    gid: Etc.getgrgid(file_stat.gid).name,
    month: date_time.strftime('%b'),
    day: date_time.day,
    time: date_time.strftime('%H:%M')
  }
end

def output(file_names)
  row_count, rem = file_names.size.divmod(MAX_COLUMN_COUNT)
  row_count += 1 unless rem.zero?

  max_name_length = file_names.empty? ? 0 : file_names.max_by(&:size).size

  matrix = Array.new(row_count) { [] }
  file_names.each_with_index do |file_name, index|
    matrix[index % row_count] << file_name
  end

  matrix.each_index do |row_index|
    column_count = matrix[row_index].size
    format_str = "%-#{max_name_length}s " * column_count
    puts format(format_str, *matrix[row_index])
  end
end

def output_with_l_option(file_info_table)
  display_items = %i[type_mode nlink uid gid size month day time]
  max_length_table = {}

  display_items.each do |display_item|
    table_with_max_length = file_info_table.empty? ? {} : file_info_table.each_value.max_by { |file_info| file_info[display_item].to_s.size }
    max_length_table[display_item] = table_with_max_length[display_item].to_s.size
  end

  block_total = file_info_table.each_value.sum { |file_info| file_info[:block] }
  puts "total #{block_total}" unless file_info_table.empty?

  format_str = display_items.map { |display_item| "%#{max_length_table[display_item]}s" }.join(' ')

  file_info_table.each do |file_name, file_info|
    attr_values = file_info.fetch_values(*display_items)
    puts format("#{format_str} %s", *attr_values, file_name)
  end
end

main
