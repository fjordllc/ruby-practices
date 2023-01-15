# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

def file_column(files)
  filename_lengths = files.map(&:length)
  (filename_lengths.max / 8 + 1) * 8
end

MAX_COLUMN = 3
def current_column(files)
  terminal_column = `tput cols`.chomp.to_i
  file_column(files) * MAX_COLUMN > terminal_column ? terminal_column / file_column(files) : MAX_COLUMN
end

def files_block(files_stat)
  files_blocks = files_stat.map(&:blocks)
  "total #{files_blocks.sum}"
end

def file_mode(file_stat)
  file_type = { 'file' => '-', 'directory' => 'd', 'link' => 'l', 'fifo' => 'p', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'socket' => 's' }
  permission = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx']
  file_permission = file_stat.mode.to_s(8).chars
  owner_permission = permission[file_permission[-3].to_i].chars
  group_permission = permission[file_permission[-2].to_i].chars
  other_permission = permission[file_permission[-1].to_i].chars
  case file_permission[-4].to_i
  when 4
    owner_permission.delete_at(-1)
    owner_permission.push('s')
  when 2
    group_permission.delete_at(-1)
    group_permission.push('s')
  when 1
    other_permission.delete_at(-1)
    other_permission.push('t')
  end
  file_type[file_stat.ftype] + [owner_permission + group_permission + other_permission].join
end

def files_link_max(files_stat)
  files_link = files_stat.map(&:nlink)
  files_link.max.to_s.length
end

def file_user_and_group_name(file_stat)
  file_user_id = file_stat.uid
  group_id = file_stat.gid
  "#{Etc.getpwuid(file_user_id).name}  #{Etc.getgrgid(group_id).name}"
end

def files_size_max(files_stat)
  files_size = files_stat.map(&:size)
  files_size.max.to_s.length
end

def file_update_time(file_stat)
  file_time = file_stat.mtime
  if file_time.between?(Date.today.prev_month(6).to_time, Time.now)
    file_time.strftime('%_m %_d %H:%M')
  else
    file_time.strftime('%_m %_d  %Y')
  end
end

params = ARGV.getopts('arl')
flags = params['a'] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags).sort
files.reverse! if params['r']
blank = ' '

if params['l']
  files_stat = files.map { |file| File.lstat(file) }
  files_name_and_stat = files.zip(files_stat).to_h
  puts files_block(files_stat)
  files_name_and_stat.each do |file_name, file_stat|
    print file_mode(file_stat) + blank * 2
    print file_stat.nlink.to_s.rjust(files_link_max(files_stat)) + blank
    print file_user_and_group_name(file_stat) + blank * 2
    print file_stat.size.to_s.rjust(files_size_max(files_stat)) + blank
    print file_update_time(file_stat) + blank
    print file_name
    puts
  end
else
  files_length = files.length
  d = (files_length.to_f / current_column(files)).ceil
  arrays = (1..d).map { |n| n.step(by: d, to: files_length).to_a }
  arrays.each do |array|
    array.each { |i| print files[i - 1].ljust(file_column(files), ' ') }
    puts
  end
end
