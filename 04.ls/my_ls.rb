#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
COLUMN_NUMBER = 3
L_OPTION_PADDING = 2

def run_ls_with_options
  has_option = options
  files = Dir.glob('*')
  if has_option[:l]
    line_up_infomations(files)
  else
    line_up_files(files)
  end
end

def options
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!
  params
end

def line_up_files(files)
  filename_max_length = files.map(&:size).max + 7
  files_with_spaces = files.map { |file| file.ljust(filename_max_length) }
  files_number = files_with_spaces.count
  rows = (files_number / COLUMN_NUMBER.to_f).ceil
  (COLUMN_NUMBER - files_number % COLUMN_NUMBER).times { files_with_spaces << '' } if files_number % COLUMN_NUMBER != 0
  output(files_with_spaces, rows)
end

def output(files, rows)
  output_files = []
  files.each_slice(rows) { |file| output_files << file }

  output_files.transpose.each do |file|
    file.each { |filename| print filename }
    puts "\n"
  end
end

def line_up_infomations(files)
  full_paths = files.map { |file_name| File.absolute_path("./#{file_name}") }
  infomations = []
  full_paths.each { |full_path| infomations << File.lstat(full_path) }
  ary = [files, infomations].transpose
  file_infomations = Hash[*ary.flatten]
  output_file_info(file_infomations)
end

def output_file_info(file_infomations)
  arrange_infomations = file_infomations
  puts "total #{total_blocks(arrange_infomations)}"

  link_length = adjust_link(arrange_infomations)
  uid_length = adjust_uid(arrange_infomations)
  gid_length = adjust_gid(arrange_infomations)
  size_length = adjust_size(arrange_infomations)

  arrange_infomations.each do |file_name, file_info|
    print filetype(file_info.ftype)
    (-3..-1).each { |num| print permission(file_info.mode.to_s(8)[num].to_i) }
    print file_info.nlink.to_s.rjust(link_length)
    print Etc.getpwuid(file_info.uid).name.rjust(uid_length)
    print Etc.getgrgid(file_info.gid).name.rjust(gid_length)
    print file_info.size.to_s.rjust(size_length)
    print file_info.atime.strftime(' %_m %e %R')
    print " #{file_name}"
    print " -> #{File.readlink(file_name)}" if file_info.ftype == 'link'
    puts "\n"
  end
end

def total_blocks(arrange_infomations)
  blocks = 0
  arrange_infomations.each_value { |file_info| blocks += file_info.blocks }
  blocks
end

def adjust_link(arrange_infomations)
  lengths = []
  arrange_infomations.each_value { |file| lengths << file.nlink.to_s.size }
  lengths.max + L_OPTION_PADDING
end

def adjust_uid(arrange_infomations)
  lengths = []
  arrange_infomations.each_value { |file| lengths << Etc.getpwuid(file.uid).name.size }
  lengths.max + L_OPTION_PADDING
end

def adjust_gid(arrange_infomations)
  lengths = []
  arrange_infomations.each_value { |file| lengths << Etc.getgrgid(file.gid).name.size }
  lengths.max + L_OPTION_PADDING
end

def adjust_size(arrange_infomations)
  lengths = []
  arrange_infomations.each_value { |file| lengths << file.size.to_s.size }
  lengths.max + L_OPTION_PADDING
end

def filetype(file_info)
  filetypes = { 'fifo' => 'p',
                'characterSpecial' => 'c',
                'directory' => 'd',
                'blockSpecial' => 'b',
                'file' => '_',
                'link' => 'l',
                'socket' => 's' }
  filetypes[file_info]
end

def permission(permisson_number)
  permission_numbers = { 0 => '---',
                         1 => '--x',
                         2 => '-w-',
                         3 => '-wx',
                         4 => 'r--',
                         5 => 'r-x',
                         6 => 'rw-',
                         7 => 'rwx' }
  permission_numbers[permisson_number]
end

run_ls_with_options
