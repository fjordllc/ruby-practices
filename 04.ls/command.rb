# frozen_string_literal: true

require 'optparse'
require 'etc'

file_list_options = ARGV.getopts('lra')
show_in_detailed_list = file_list_options['l']
show_in_reversed_order = file_list_options['r']
show_hidden_files = file_list_options['a']

current_path = ARGV[0].nil? ? __dir__ : ARGV[0]

MARGIN = 3
COLUMN_COUNT = 3
FILE_PERMISSION_SYMBOLS = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze
FILE_TYPE_SYMBOLS = {
  'file' => '-',
  'directory' => 'd',
  'link' => 'l',
  'fifo' => 'p',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'socket' => 's'
}.freeze

def add_spacing(filename, column_spacing)
  filename.ljust(column_spacing + MARGIN)
end

def formatted_print(ordered_files, column_spacing, row_count)
  row_count.times do |row_index|
    COLUMN_COUNT.times do |column_index|
      formatted_row = ordered_files[column_index][row_index].nil? ? ' ' : ordered_files[column_index][row_index]
      print(add_spacing(formatted_row, column_spacing))
    end
    puts('')
  end
end

def file_mode_symbol(file_mode)
  file_mode_octal = file_mode.to_s(8).rjust(6, '0')
  permission_symbol = ''

  file_mode_octal.slice(3, 3).each_char do |permission_number|
    current_permission = FILE_PERMISSION_SYMBOLS[permission_number]
    permission_symbol += current_permission
  end
  permission_symbol
end

def file_type_symbol(file_type)
  FILE_TYPE_SYMBOLS[file_type]
end

def print_long_list(long_mode_files, column_max_lengths)
  long_mode_files.each do |file|
    print file['file_permission']
    print file['file_owner'].rjust(column_max_lengths['file_owner'] + MARGIN)
    print file['file_group'].rjust(column_max_lengths['file_group'] + MARGIN)
    print file['file_size'].rjust(column_max_lengths['file_size'] + MARGIN)
    print file['file_last_modified'].rjust(column_max_lengths['file_last_modified'] + MARGIN).ljust(column_max_lengths['file_last_modified'] + MARGIN * 2)
    print file['file_name']
    puts ''
  end
end

def calculate_max_length(long_mode_files)
  column_max_lengths = {
    'file_owner' => 0,
    'file_group' => 0,
    'file_size' => 0,
    'file_last_modified' => 11,
    'file_name' => 0
  }

  long_mode_files.each do |file|
    column_max_lengths['file_owner'] = file['file_owner'].length if file['file_owner'].length > column_max_lengths['file_owner']
    column_max_lengths['file_group'] = file['file_group'].length if file['file_group'].length > column_max_lengths['file_group']
    column_max_lengths['file_size'] = file['file_size'].length if file['file_size'].length > column_max_lengths['file_size']
    column_max_lengths['file_name'] = file['file_name'].length if file['file_name'].length > column_max_lengths['file_name']
  end
  column_max_lengths
end

def long_list(files)
  long_mode_files = []
  files.each do |file|
    file_details = File.stat(file)
    formatted_file_long_mode = {
      'file_permission' => file_type_symbol(file_details.ftype) + file_mode_symbol(file_details.mode),
      'file_owner' => Etc.getpwuid(file_details.uid).name,
      'file_group' => Etc.getgrgid(file_details.gid).name,
      'file_size' => file_details.size.to_s,
      'file_last_modified' => file_details.mtime.strftime('%-m %-d %R'),
      'file_name' => File.basename(file)
    }
    long_mode_files << formatted_file_long_mode
  end
  column_max_lengths = calculate_max_length(long_mode_files)
  print_long_list(long_mode_files, column_max_lengths)
end

def normal_list(files)
  file_count = files.length
  row_count = (file_count / COLUMN_COUNT.to_f).ceil
  max_length = 0
  ordered_file_list = [] << []

  files.each_with_index do |file_path, index|
    ordered_file_list << [] if (index % row_count).zero?
    file_name = File.basename(file_path)
    max_length = file_name.length if file_name.length > max_length
    ordered_file_list[index / row_count].append(file_name)
  end

  formatted_print(ordered_file_list, max_length, row_count)
end

files = if show_hidden_files
          Dir.glob("#{current_path}/*", File::FNM_DOTMATCH)
        else
          Dir.glob("#{current_path}/*")
        end

files.reverse! if show_in_reversed_order

if show_in_detailed_list
  long_list(files)
else
  normal_list(files)
end
