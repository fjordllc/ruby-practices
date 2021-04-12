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
  begin
    options = ARGV.getopts('a', 'l', 'r')
  rescue OptionParser::InvalidOption => e
    puts e.message
    exit
  end

  path_list = ARGV
  path_list.push '.' if path_list.empty?

  path_list.each do |target|
    result = get_list_files(target, option_a: options['a'], option_r: options['r'])

    result << target if result.empty?

    output_new_line(path_list.size)

    if options['l']
      result_l = {}
      result.each { |file| result_l[file] = get_file_stat(target, file) }
      output_l(result_l)
    else
      output(result)
    end
  end
end

def get_list_files(path, option_a: false, option_r: false)
  list_file = option_a ? Dir.glob('*', File::FNM_DOTMATCH, base: path) : Dir.glob('*', base: path)
  list_file.sort!

  option_r ? list_file.reverse : list_file
end

def get_file_stat(path, file_name)
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

def output_new_line(num)
  puts "\n" if num > 1
end

def output(array)
  arr_size_div = array.size.div(MAX_COLUMN_COUNT)
  row_num = (array.size % MAX_COLUMN_COUNT).zero? ? arr_size_div : arr_size_div + 1

  max_str = 0
  array.each do |item|
    item_size = item.to_s.size
    max_str = item_size if max_str < item_size
  end

  output = Array.new(row_num) { [] }
  array.each_with_index do |item, index|
    output[index % row_num] << item
  end

  output.each_index do |index|
    size = output[index].size
    format_str = "%-#{max_str}s " * size
    puts format(format_str, *output[index]) unless size.zero?
  end
end

def output_l(hash)
  array_size = 0
  hash.each_value do |value|
    array_size = value.size
    break unless array_size.zero?
  end

  max_length_list = Array.new(array_size) { 0 }

  hash.each_value do |array|
    array.each_with_index do |item, index|
      item_size = item.to_s.size
      max_length_list[index] = item_size if max_length_list[index] < item_size
    end
  end

  total = 0
  hash.each_value { |array| total += array[8] }
  puts "total #{total}"

  format_str = "%#{max_length_list.slice(0..7).join('s %')}s %s"
  hash.each do |key, value|
    puts format(format_str, *value.slice(0..7), key)
  end
end

main
