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

  if params['l']
    show_the_total_number_of_blocks(dirs)

    file_stats = create_file_stats(dirs)

    maximum_characters = get_maximum_number_of_characters(dirs, file_stats)

    show_file_details(dirs, file_stats, maximum_characters)

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

def create_file_stats(dirs)
  file_stats = []
  dirs.each do |dir|
    fs = File.lstat(dir)
    permitted_attributes = fs.mode.to_s(8).to_i.digits.take(3).reverse
    file_stat = {
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
  # ls.rb:94:3: W: Lint/UselessAssignment: Useless assignment to variable - maximum_characters.
  # ls.rb:94:3: C: [Correctable] Style/RedundantAssignment: Redundant assignment before returning detected.
  {
    hard_link: files_stats[:hard_links].max_by(&:size).size,
    username: files_stats[:usernames].max_by(&:size).size,
    groupname: files_stats[:groupnames].max_by(&:size).size,
    file_size: files_stats[:file_sizes].max_by(&:size).size
  }
end

def show_file_details(dirs, file_stats, maximum_characters)
  stat_number = 0
  dirs.each do |dir|
    File.lstat(dir)
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
