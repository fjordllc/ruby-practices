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

  show_the_total_number_of_blocks(dirs, filestat_in_directory)

  file_stats = create_file_stats(dirs, filestat_in_directory)

  maximum_characters = get_maximum_number_of_characters(dirs, file_stats)

  show_file_details(dirs, file_stats, maximum_characters)
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
  fs = []
  dirs.each do |dir|
    fs << File.lstat(dir)
  end
  fs
end

def show_the_total_number_of_blocks(dirs, filestat_in_directory)
  stat_number = 0
  total_of_blocks = 0
  dirs.each do
    total_of_blocks += filestat_in_directory[stat_number].blocks
    stat_number += 1
  end
  puts "total #{total_of_blocks}"
end

def create_file_stats(dirs, filestat_in_directory)
  stat_number = 0
  file_stats = []
  dirs.each do |dir|
    permitted_attributes = filestat_in_directory[stat_number].mode.to_s(8).to_i.digits.take(3).reverse
    file_stat = {
      permitted_attributes: FILE_TYPE[filestat_in_directory[stat_number].ftype],
      file_permission: PERMISSION_STRING[permitted_attributes[0]] + PERMISSION_STRING[permitted_attributes[1]] + PERMISSION_STRING[permitted_attributes[2]],
      hard_link: filestat_in_directory[stat_number].nlink.to_s,
      username: Etc.getpwuid(filestat_in_directory[stat_number].uid).name,
      groupname: Etc.getgrgid(filestat_in_directory[stat_number].gid).name,
      file_size: filestat_in_directory[stat_number].size.to_s,
      update_date: filestat_in_directory[stat_number].mtime.strftime('%_m %e %H:%M'),
      file_name: dir
    }
    file_stats << file_stat
    stat_number += 1
  end
  file_stats
end

def get_maximum_number_of_characters(dirs, file_stats)
  stat_number = 0
  files_stats = { hard_links: [], usernames: [], groupnames: [], file_sizes: [] }
  dirs.each do
    files_stats[:hard_links] << file_stats[stat_number][:hard_link]
    files_stats[:usernames] << file_stats[stat_number][:username]
    files_stats[:groupnames] << file_stats[stat_number][:groupname]
    files_stats[:file_sizes] << file_stats[stat_number][:file_size]
    stat_number += 1
  end
  {
    hard_link: files_stats[:hard_links].max_by(&:size).size,
    username: files_stats[:usernames].max_by(&:size).size,
    groupname: files_stats[:groupnames].max_by(&:size).size,
    file_size: files_stats[:file_sizes].max_by(&:size).size
  }
end

def show_file_details(dirs, file_stats, maximum_characters)
  stat_number = 0
  dirs.each do
    puts "#{file_stats[stat_number][:permitted_attributes]}#{file_stats[stat_number][:file_permission]}" \
    "  #{file_stats[stat_number][:hard_link].rjust(maximum_characters[:hard_link])}" \
    " #{file_stats[stat_number][:username].ljust(maximum_characters[:username])}" \
    "  #{file_stats[stat_number][:groupname].ljust(maximum_characters[:groupname])}" \
    "  #{file_stats[stat_number][:file_size].rjust(maximum_characters[:file_size])}" \
    " #{file_stats[stat_number][:update_date]} #{file_stats[stat_number][:file_name]}"
    stat_number += 1
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
