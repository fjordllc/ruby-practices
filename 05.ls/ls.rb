#!/usr/bin/env ruby
# frozen_string_literal: true

MAXIMUM_COLUMN = 3
FILE_TYPE = {
  'fifo' => 'p',
  'characterSpecial' => 'c',
  'directory' => 'd',
  'blockSpecial' => 'b',
  'file' => '-',
  'link' => 'l',
  'socket' => 's'
}.freeze
PERMISSION_STRING = {
  0 => '---',
  1 => '--x',
  2 => '-w-',
  3 => '-wx',
  4 => 'r--',
  5 => 'r-x',
  6 => 'rw-',
  7 => 'rwx'
}.freeze
require 'optparse'
require 'etc'

def main
  params = ARGV.getopts('l')
  dirs = Dir.glob('*')
  params['l'] ? print_ls_command_l_option(dirs) : print_ls_command(dirs)
end

def print_ls_command_l_option(dirs)
  filestat_in_directory = repeat_through_file_stat(dirs)

  show_the_total_number_of_blocks(filestat_in_directory)

  file_stats = create_file_stats(filestat_in_directory)

  file_stat = fetch_file_stat(file_stats)

  maximum_characters = fetch_maximum_number_of_characters(file_stat)

  show_file_details(file_stats, maximum_characters)
end

def print_ls_command(dirs)
  files = []
  total_number_of_files = dirs.size
  number_of_lines = (total_number_of_files.to_f / MAXIMUM_COLUMN).ceil(0)

  slice_the_file(dirs, number_of_lines, files)

  align_the_number_of_elements(files, total_number_of_files)

  sorted_files = files.transpose

  show_files(dirs, sorted_files)
end

def repeat_through_file_stat(dirs)
  fs_directory = []
  dirs.each do |dir|
    fs = {
      filestat: File.lstat(dir),
      filename: dir
    }
    fs_directory << fs
  end
  fs_directory
end

def show_the_total_number_of_blocks(filestat_in_directory)
  total_of_blocks = 0
  filestat_in_directory.each do |filestat_dir|
    total_of_blocks += filestat_dir[:filestat].blocks
  end
  puts "total #{total_of_blocks}"
end

def create_file_stats(filestat_in_directory)
  file_stats = []
  filestat_in_directory.each do |filestat_dir|
    permitted_attributes = filestat_dir[:filestat].mode.to_s(8).to_i.digits.take(3).reverse
    file_stat = {
      permitted_attributes: FILE_TYPE[filestat_dir[:filestat].ftype],
      file_permission: PERMISSION_STRING[permitted_attributes[0]] + PERMISSION_STRING[permitted_attributes[1]] + PERMISSION_STRING[permitted_attributes[2]],
      hard_link: filestat_dir[:filestat].nlink.to_s,
      username: Etc.getpwuid(filestat_dir[:filestat].uid).name,
      groupname: Etc.getgrgid(filestat_dir[:filestat].gid).name,
      file_size: filestat_dir[:filestat].size.to_s,
      update_date: filestat_dir[:filestat].mtime.strftime('%_m %e %H:%M'),
      file_name: filestat_dir[:filename]
    }
    file_stats << file_stat
  end
  file_stats
end

def fetch_file_stat(file_stats)
  {
    hard_link: file_stats.map { |file_stat| file_stat[:hard_link] },
    username: file_stats.map { |file_stat| file_stat[:username] },
    groupname: file_stats.map { |file_stat| file_stat[:groupname] },
    file_size: file_stats.map { |file_stat| file_stat[:file_size] }
  }
end

def fetch_maximum_number_of_characters(file_stat)
  {
    max_hard_link: file_stat[:hard_link].max_by(&:size).size,
    max_username: file_stat[:username].max_by(&:size).size,
    max_groupname: file_stat[:groupname].max_by(&:size).size,
    max_file_size: file_stat[:file_size].max_by(&:size).size
  }
end

def show_file_details(file_stats, maximum_characters)
  file_stats.each do |file_stat|
    puts "#{file_stat[:permitted_attributes]}#{file_stat[:file_permission]}" \
    "  #{file_stat[:hard_link].rjust(maximum_characters[:max_hard_link])}" \
    " #{file_stat[:username].ljust(maximum_characters[:max_username])}" \
    "  #{file_stat[:groupname].ljust(maximum_characters[:max_groupname])}" \
    "  #{file_stat[:file_size].rjust(maximum_characters[:max_file_size])}" \
    " #{file_stat[:update_date]} #{file_stat[:file_name]}"
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
