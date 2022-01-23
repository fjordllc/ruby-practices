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
  file_stats = create_file_stats(dirs)

  show_the_total_number_of_blocks(file_stats)

  sorted_file_stats = sort_file_stats(file_stats)

  maximum_characters = fetch_maximum_number_of_characters(sorted_file_stats)

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

def create_file_stats(dirs)
  file_stats = []
  dirs.each do |dir|
    fs = File.lstat(dir)
    permitted_attributes = fs.mode.to_s(8).to_i.digits.take(3).reverse
    file_stat = {
      file_blocks: fs.blocks,
      permitted_attributes: FILE_TYPE[fs.ftype],
      file_permission: PERMISSION_STRING[permitted_attributes[0]] + PERMISSION_STRING[permitted_attributes[1]] + PERMISSION_STRING[permitted_attributes[2]],
      hard_link: fs.nlink.to_s,
      username: Etc.getpwuid(fs.uid).name,
      groupname: Etc.getgrgid(fs.gid).name,
      file_size: fs.size.to_s,
      update_date: fs.mtime.strftime('%_m %e %H:%M'),
      file_name: dir
    }
    file_stats << file_stat
  end
  file_stats
end

def show_the_total_number_of_blocks(file_stats)
  total_of_blocks = 0
  file_stats.each do |filestats|
    total_of_blocks += filestats[:file_blocks]
  end
  puts "total #{total_of_blocks}"
end

def sort_file_stats(file_stats)
  {
    hard_link: file_stats.map { |file_stat| file_stat[:hard_link] },
    username: file_stats.map { |file_stat| file_stat[:username] },
    groupname: file_stats.map { |file_stat| file_stat[:groupname] },
    file_size: file_stats.map { |file_stat| file_stat[:file_size] }
  }
end

def fetch_maximum_number_of_characters(sorted_file_stats)
  {
    max_hard_link: sorted_file_stats[:hard_link].max_by(&:size).size,
    max_username: sorted_file_stats[:username].max_by(&:size).size,
    max_groupname: sorted_file_stats[:groupname].max_by(&:size).size,
    max_file_size: sorted_file_stats[:file_size].max_by(&:size).size
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
