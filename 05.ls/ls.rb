#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('l')
files_of_directory = Dir.glob('*')

def make_divided_list(files, num)
  num_to_slice = (files.size.to_f / num).ceil

  ret = files.each_slice(num_to_slice).to_a
  ret.last << nil while ret.last.size < num_to_slice

  ret
end

def make_adjustment_width(files, multiple)
  max_filename_length = files.max_by(&:size).size
  (max_filename_length / multiple + 1) * multiple
end

def show_files(files)
  divided_list = make_divided_list(files, 3)
  adjustment_width = make_adjustment_width(files, 8)

  divided_list.transpose.each do |files_divided|
    files_divided.each do |file|
      print file.to_s.ljust(adjustment_width)
    end
    print "\n"
  end
end

file_stat_list = files_of_directory.map { |file| File::Stat.new(file) }
numbers_of_adjustment_width = {
  max_digit_of_num_of_link: file_stat_list.map { |stat| stat.nlink.to_s.size }.max,
  max_user_name_length: file_stat_list.map { |stat| Etc.getpwuid(stat.uid).name.size }.max,
  max_group_name_length: file_stat_list.map { |stat| Etc.getgrgid(stat.gid).name.size }.max,
  max_digit_of_file_size: file_stat_list.map { |stat| stat.size.to_s.size }.max
}

def convert_to_symbol(str)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[str]
end

def show_total_of_blocks(files)
  total = 0

  files.each do |file|
    file = File::Stat.new(file)
    total += file.blocks
  end
  puts "total #{total}"
end

def show_file_stats(files, numbers)
  files.each do |file|
    fs = File::Stat.new(file)
    file_permission = [
      fs.ftype == 'file' ? '-' : fs.ftype[0],
      fs.mode.to_s(8)[-3, 3].chars.map { |num| convert_to_permission(num) }.join
    ].join
    time_format = fs.mtime.between?(Time.now - 15_552_000, Time.now) ? '%_m %e %R' : '%_m %e  %Y'

    file_stats = [
      file_permission,
      fs.nlink.to_s.rjust(numbers[:max_digit_of_num_of_link] + 1),
      Etc.getpwuid(fs.uid).name.ljust(numbers[:max_user_name_length] + 1),
      Etc.getgrgid(fs.gid).name.ljust(numbers[:max_group_name_length] + 1),
      fs.size.to_s.rjust(numbers[:max_digit_of_file_size]),
      fs.mtime.strftime(time_format),
      file
    ].join(' ')

    puts file_stats
  end
end

divided_list = make_divided_list(files_of_directory, 3)
adjustment_width = make_adjustment_width(files_of_directory, 8)

if options['l'] == true
  show_total_of_blocks(files_of_directory)
  show_file_stats(files_of_directory, numbers_of_adjustment_width)
else
  show_files(divided_list, adjustment_width)
end
