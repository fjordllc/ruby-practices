# frozen_string_literal: true
require 'optparse'
require 'etc'
require 'debug'

file_list_options = ARGV.getopts('l')
show_in_detailed_list = file_list_options['l']

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
}
FILE_TYPE_SYMBOLS = {
  'file' => '-',
  'directory' => 'd',
  'link' => 'l',
  'fifo' => 'p',
  'characterSpecial' => 'c',  
  'blockSpecial' => 'b',
  'socket' => 's'
}

def add_spacing(filename, column_spacing)
  filename.ljust(column_spacing + MARGIN)
end

def formatted_print(ordered_file_list, column_spacing, row_count)
  row_count.times do |row_index|
    COLUMN_COUNT.times do |column_index|
      formatted_row = ordered_file_list[column_index][row_index].nil? ? ' ' : ordered_file_list[column_index][row_index]
      print(add_spacing(formatted_row, column_spacing))
    end
    puts('')
  end
end

def file_mode_symbol(file_mode)
  file_mode_octal = file_mode.to_s(8).rjust(6, '0')
  permission_symbol = ""

  case file_mode_octal[2]
  when '1'
    special_permission = 'Sticky Bit'
  when '2'
    special_permission = 'SGID'
  when '3'
    special_permission = 'SUID'
  end

  file_mode_octal.slice(3,3).each_char.with_index do |permission_number, index|
    current_permission = FILE_PERMISSION_SYMBOLS[permission_number]

    if special_permission == 'SUID' && index == 3
      if current_permission[0] == 'x'
        current_permission[0].gsub(/.$/, 's')
      else
        current_permission[0].gsub(/.$/, 'S')
      end

    elsif special_permission == 'SGID' && index == 4
      if current_permission[1] == 'x'
        current_permission[1].gsub(/.$/, 's')
      else
        current_permission[1].gsub(/.$/, 'S')
      end

    elsif special_permission == 'Sticky Bit' && index == 5
      if current_permission[2] == 'x'
        current_permission[2].gsub(/.$/, 't')
      else
        current_permission[2].gsub(/.$/, 'T')
      end
    end

    permission_symbol += current_permission
  end
  permission_symbol
end

def file_type_symbol(file_type)
  FILE_TYPE_SYMBOLS[file_type]
end

def print_long_list(file_list_long_mode, column_max_lengths)
  file_list_long_mode.each do |file|
    print file['file_permission']
    print file['file_owner'].rjust(column_max_lengths['file_owner'] + MARGIN)
    print file['file_group'].rjust(column_max_lengths['file_group'] + MARGIN)
    print file['file_size'].rjust(column_max_lengths['file_size'] + MARGIN)
    print file['file_last_modified'].rjust(column_max_lengths['file_last_modified'] + MARGIN).ljust(column_max_lengths['file_last_modified'] + MARGIN*2)
    print file['file_name']
    puts ''
  end
end


def long_list(file_list)
  file_list_long_mode = []
  column_max_lengths = {
    "file_owner" => 0,
    "file_group" => 0,
    "file_size" => 0,
    "file_last_modified" => 11,
    "file_name" => 0
  }
  file_list.each do |file|
    file_details = File.stat(file)
    formatted_file_long_mode = {
      "file_permission" => file_type_symbol(file_details.ftype) + file_mode_symbol(file_details.mode),
      "file_owner" => Etc.getpwuid(file_details.uid).name,
      "file_group" => Etc.getgrgid(file_details.gid).name,
      "file_size" => file_details.size.to_s,
      "file_last_modified" => file_details.mtime.strftime("%-m %-d %R"),
      "file_name" =>  File.basename(file)
    }
    column_max_lengths['file_owner'] = formatted_file_long_mode['file_owner'].length if formatted_file_long_mode['file_owner'].length > column_max_lengths['file_owner']
    column_max_lengths['file_group'] = formatted_file_long_mode['file_group'].length if formatted_file_long_mode['file_group'].length > column_max_lengths['file_group']
    column_max_lengths['file_size'] = formatted_file_long_mode['file_size'].length if formatted_file_long_mode['file_size'].length > column_max_lengths['file_size']
    column_max_lengths['file_name'] = formatted_file_long_mode['file_name'].length if formatted_file_long_mode['file_name'].length > column_max_lengths['file_name']

    file_list_long_mode << formatted_file_long_mode
  end
 
  print_long_list(file_list_long_mode, column_max_lengths)
end

file_list = Dir.glob("#{current_path}/*")
file_count = file_list.length
row_count = (file_count / COLUMN_COUNT.to_f).ceil
if show_in_detailed_list
  long_list(file_list) 
else
  max_length = 0
  ordered_file_list = [] << []

  file_list.each_with_index do |file_path, index|
    ordered_file_list << [] if (index % row_count).zero?
    file_name = File.basename(file_path)
    max_length = file_name.length if file_name.length > max_length
    ordered_file_list[index / row_count].append(file_name)
  end

  formatted_print(ordered_file_list, max_length, row_count)
end
