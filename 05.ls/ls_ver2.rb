# frozen_string_literal: true

require 'optparse'
require 'debug'
require 'date'

COLUMN_NUMBER = 3
SPACE = 5

def main(**options)
  files = options[:a] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  files = options[:r] ? files.reverse! : files
  options.key?(:l) ? print_long_filename(files) : print_short_filename(files)
end

def option_parse
  options = {}
  OptionParser.new do |opt|
    opt.on('-l', '--long', 'long list') { |v| options[:l] = v }
    opt.on('-a', '--all', 'do not ignore entries starting with .') { |v| options[:a] = v }
    opt.on('-r', 'reverse', 'reverse the sort order') { |v| options[:r] = v }
    opt.parse!(ARGV)
  end
  options
end

def print_long_filename(files)
  stat_file = files.map { |s| File::Stat.new(s) }
  print_total_blocks(stat_file) if stat_file.size > 1
  stat_file.each_with_index do |convert, num|
    filetype(convert)
    permission(convert)
    hardlink(stat_file, convert)
    user(convert)
    group(convert)
    filesize(stat_file, convert)
    timestamp(convert)
    filename(files, num)
    puts "#{filetype(convert)}#{permission(convert)} #{hardlink(stat_file, convert)}\
    #{user(convert)} #{group(convert)}  #{filesize(stat_file, convert)} #{timestamp(convert)} #{filename(files, num)} "
  end
end

def print_total_blocks(stat_file)
  puts "total #{stat_file.map(&:blocks).sum}"
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

def hardlink(stat_file, convert)
  max_lenth = stat_file.map(&:nlink).max.to_s.bytesize
  convert.nlink.to_s.rjust(max_lenth)
end

def user(convert)
  user_id = convert.uid
  Etc.getpwuid(user_id).name
end

def group(convert)
  group_id = convert.gid
  Etc.getgrgid(group_id).name
end

def filesize(stat_file, convert)
  max_lenth = stat_file.map(&:size).max.to_s.bytesize
  convert.size.to_s.rjust(max_lenth)
end

def timestamp(convert)
  time_info = convert.mtime
  time_info.strftime('%_m %_d %_R')
end

def filename(files, num)
  files[num]
end

def print_short_filename(files)
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
