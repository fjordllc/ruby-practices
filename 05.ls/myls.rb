#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

OPTIONS = ARGV.getopts('a', 'r', 'l')
FILETYPES_LIST = {
  'file' => '-',
  'directory' => 'd',
  'link' => 'l'
}.freeze

PERMISSION_LIST = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-WX',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def main
  file_list = make_list
  return if file_list.size.zero?

  OPTIONS['l'] ? file_details : display(file_list)
end

def make_list
  list = Dir.glob('*', OPTIONS['a'] ? File::FNM_DOTMATCH : 0).sort
  OPTIONS['r'] ? list.reverse : list
end

def file
  make_list.map { |list| File.lstat(list) }
end

def total
  total_number = 0
  file.each do |file_element|
    total_number += file_element.blocks
  end
  puts "total #{total_number}"
end

def ftype_permission
  filetype = file.map { |file_element| FILETYPES_LIST[file_element.ftype] }

  permission = file.map { |file_element| file_element.mode.to_s(8).slice(-3..-1).chars }.map { |array| array.map { |char| PERMISSION_LIST[char] } }

  count = 0
  ftper = []
  while count < filetype.size
    ftper << [filetype[count], permission[count]].join
    count += 1
  end
  ftper
end

def hardlink
  link_number = file.map { |file_element| file_element.nlink.to_s }
  max_digit = link_number.max_by(&:size).size
  link_number.map { |h| " #{h.rjust(max_digit)}" }
end

def orner_name
  file.map { |file_element| Etc.getpwuid(file_element.uid).name }
end

def group_name
  file.map { |file_element| " #{Etc.getgrgid(file_element.gid).name}" }
end

def filesize
  file_size = file.map { |file_element| file_element.size.to_s }
  longest_filesize = file_size.max_by(&:size).size
  file_size.map { |f| " #{f.rjust(longest_filesize)}" }
end

def time_stamp
  file.map { |file_element| file_element.mtime.strftime('%_m %_d %R') }
end

def symlink_name
  make_list.map { |list_element| FileTest.symlink?(list_element) ? "#{list_element} -> #{File.readlink(list_element)}" : list_element }
end

def file_details
  total
  result = [ftype_permission, hardlink, orner_name, group_name, filesize, time_stamp, symlink_name]
  result.transpose.map { |display| puts display.join(' ') }
end

def display(file_list)
  display_width = `tput cols`.to_i

  max_columns = 3
  longest_name_size = file_list.max_by(&:size).size
  minus_columns = (0...max_columns).find { longest_name_size < display_width / (max_columns - _1) } || max_columns - 1
  columns_number = max_columns - minus_columns

  columns_width = display_width / columns_number

  vertical = (file_list.size / columns_number.to_f).ceil

  slice = file_list.map { |d| d.ljust(columns_width) }.each_slice(vertical).to_a

  slice.map { |element| element.values_at(0...vertical) }.transpose.each { |display| puts display.join('') }
end

main
