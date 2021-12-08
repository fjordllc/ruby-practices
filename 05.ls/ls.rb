#!/usr/bin/env ruby
# frozen_string_literal: true

MAXIMUM_COLUMN = 3
require 'optparse'
require 'etc'

def main
  params = ARGV.getopts('l')
  dirs = Dir.glob('*')

  if params['l']
    array_of_hard_links = []
    array_of_file_sizes = []

    show_the_total_number_of_blocks(dirs)

    putting_file_details_into_an_array(dirs, array_of_hard_links, array_of_file_sizes)

    show_file_details(dirs, array_of_hard_links, array_of_file_sizes)

  else
    files = []
    total_number_of_files = dirs.size
    number_of_lines = (total_number_of_files.to_f / MAXIMUM_COLUMN).ceil(0)

    slice_the_file(dirs, number_of_lines, files)

    align_the_number_of_elements(files, total_number_of_files)

    sorted_files = files.transpose

    show_files(dirs, sorted_files)
  end
end

def show_the_total_number_of_blocks(dirs)
  total_of_blocks = 0
  dirs.each do |dir|
    fs = File.lstat(dir)
    total_of_blocks += fs.blocks
  end
  puts "total #{total_of_blocks}"
end

def putting_file_details_into_an_array(dirs, array_of_hard_links, array_of_file_sizes)
  dirs.each do |dir|
    fs = File.lstat(dir)
    array_of_hard_links << fs.nlink.to_s
    array_of_file_sizes << fs.size.to_s
  end
end

def show_file_details(dirs, array_of_hard_links, array_of_file_sizes)
  file_type = { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l', 'socket' => 's' }
  permission_string = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }

  dirs.each do |dir|
    fs = File.lstat(dir)
    permitted_attributes = fs.mode.to_s(8).to_i.digits.take(3).reverse
    file_permission = permission_string[permitted_attributes[0]] + permission_string[permitted_attributes[1]] + permission_string[permitted_attributes[2]]
    hard_link = fs.nlink.to_s
    hard_link_digit = array_of_hard_links.max_by(&:size).size
    username = Etc.getpwuid(fs.uid).name
    groupname = Etc.getgrgid(fs.gid).name
    file_size = fs.size.to_s
    file_size_digit = array_of_file_sizes.max_by(&:size).size
    update_date = fs.mtime.strftime('%_m %e %H:%M')
    puts "#{file_type[fs.ftype]}#{file_permission}  #{hard_link.rjust(hard_link_digit)} " \
         "#{username}  #{groupname}  #{file_size.rjust(file_size_digit)} #{update_date} #{dir}"
  end
end

def slice_the_file(dirs, number_of_lines, files)
  dirs.each_slice(number_of_lines) { |n| files << n }
end

def align_the_number_of_elements(files, total_number_of_files)
  return unless files.size >= MAXIMUM_COLUMN && total_number_of_files % MAXIMUM_COLUMN != 0

  (MAXIMUM_COLUMN - total_number_of_files % MAXIMUM_COLUMN).to_i.times { files.last << nil }
end

def show_files(dirs, sorted_files)
  longest_name = dirs.max_by(&:size)
  margin = 6
  sorted_files.each do |sorted_file|
    sorted_file.each do |s|
      print s.to_s.ljust(longest_name.size + margin)
    end
    puts
  end
end

main
