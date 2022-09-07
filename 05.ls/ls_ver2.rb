# frozen_string_literal: true

require 'optparse'
require 'debug'
require 'date'

COLUMN_NUMBER = 3
SPACE = 5

def main(options = {})
  stat_file = file_info
  options.key?(:l) ? print_long_filename(stat_file) : print_short_filename
end

def option_parse
  options = {}
  OptionParser.new do |opt|
    opt.on('-l', '--long', 'long list') do |v|
      options[:l] = v
    end
    opt.parse!(ARGV)
  end
  options
end

def file_info
  Dir.glob('*').map { |s| File::Stat.new(s) }
end

def print_long_filename(stat_file)
  print_total_blocks(stat_file) if stat_file.size > 1
  stat_file.each_with_index do |convert, num|
    filetype(convert)
    permission(convert)
    hardlink(convert)
    user(convert)
    group(convert)
    filesize(convert)
    time_stamp(convert)
    filename(num)
    puts "#{filetype(convert)}#{permission(convert)} #{hardlink(convert)}\
    #{user(convert)} #{group(convert)}  #{filesize(convert)} #{time_stamp(convert)} #{filename(num)} "
  end
end

def print_total_blocks(stat_file)
  total_blocks = stat_file.map(&:blocks)
  puts "total #{total_blocks.sum}"
end

def filetype(convert)
  filetype_name = convert.ftype
  filetype_convert_name = { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l',
                            'socket' => 's' }.freeze
  filetype_convert_name[filetype_name]
end

def permission(convert)
  octal_permission = convert.mode.to_s(8).to_i % 1000
  octal_permission.to_s.gsub(/[0-7]/, '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx')
end

def hardlink(convert)
  convert.nlink.to_s.rjust(2)
end

def user(convert)
  user_id = convert.uid
  Etc.getpwuid(user_id).name.rjust(2)
end

def group(convert)
  group_id = convert.gid
  Etc.getgrgid(group_id).name.rjust(4)
end

def filesize(convert)
  convert.size.to_s.rjust(4)
end

def time_stamp(convert)
  time_info = convert.mtime
  time_info.strftime('%_m %_d %_R')
end

def filename(num)
  files = Dir.glob('*')
  files[num]
end

def print_short_filename
  files = Dir.glob('*').sort
  row_number = (files.size.to_f / COLUMN_NUMBER).ceil
  rest_of_row = files.size % COLUMN_NUMBER
  max_column_width = files.compact.max_by(&:size).size + SPACE
  filename_with_space = files.map { |space| space.to_s.ljust(max_column_width) }
  (row_number * COLUMN_NUMBER - files.size).times { filename_with_space.push(nil) } if rest_of_row != 0
  files_arrays = filename_with_space.each_slice(row_number).to_a

  files_arrays.transpose.each do |index|
    puts index.join
  end
end

main(**option_parse)
