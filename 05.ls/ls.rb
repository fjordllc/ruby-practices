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

def make_file_mode(file_stat)
  [
    file_stat.ftype == 'file' ? '-' : file_stat.ftype[0],
    file_stat.mode.to_s(8)[-3, 3].chars.map { |str| convert_to_symbol(str) }.join
  ].join
end

def make_last_modified_time(file_stat)
  file_stat.mtime.strftime(file_stat.mtime.between?(Time.now - (60 * 60 * 24 * 180), Time.now) ? '%_m %e %R' : '%_m %e  %Y')
end

def make_adjustment_width_numbers(files)
  file_stat_list = files.map { |file| File::Stat.new(file) }
  {
    max_digit_of_num_of_link: file_stat_list.map { |stat| stat.nlink.to_s.size }.max,
    max_owner_name_length: file_stat_list.map { |stat| Etc.getpwuid(stat.uid).name.size }.max,
    max_group_name_length: file_stat_list.map { |stat| Etc.getgrgid(stat.gid).name.size }.max,
    max_digit_of_num_of_byte: file_stat_list.map { |stat| stat.size.to_s.size }.max
  }
end

def make_display_format_list(files)
  numbers = make_adjustment_width_numbers(files)

  files.map do |file|
    fs = File::Stat.new(file)

    [
      make_file_mode(fs),
      fs.nlink.to_s.rjust(numbers[:max_digit_of_num_of_link] + 1),
      Etc.getpwuid(fs.uid).name.ljust(numbers[:max_owner_name_length] + 1),
      Etc.getgrgid(fs.gid).name.ljust(numbers[:max_group_name_length] + 1),
      fs.size.to_s.rjust(numbers[:max_digit_of_num_of_byte]),
      make_last_modified_time(fs),
      file
    ]
  end
end

def show_total_of_blocks(files)
  total = files.map { |file| File::Stat.new(file).blocks }.sum
  puts "total #{total}"
end

def show_file_stats(files)
  display_format_list = make_display_format_list(files)
  file_stats = display_format_list.map { |stat| stat.join(' ') }.join("\n")
  show_total_of_blocks(files)
  puts file_stats
end

options['l'] == true ? show_file_stats(files_of_directory) : show_files(files_of_directory)
