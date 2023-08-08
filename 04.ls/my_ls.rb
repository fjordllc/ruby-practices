#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
COLUMN_NUMBER = 3
L_OPTION_PADDING = 2
FILETYPES = { 'fifo' => 'p',
              'characterSpecial' => 'c',
              'directory' => 'd',
              'blockSpecial' => 'b',
              'file' => '_',
              'link' => 'l',
              'socket' => 's' }.freeze
PERMISSION_NUMBERS = { 0 => '---',
                       1 => '--x',
                       2 => '-w-',
                       3 => '-wx',
                       4 => 'r--',
                       5 => 'r-x',
                       6 => 'rw-',
                       7 => 'rwx' }.freeze

def run_ls_with_options
  has_option = options
  files = (has_option[:a] ? Dir.entries('.').sort : Dir.glob('*'))
  files.reverse! if has_option[:r]
  if has_option[:l]
    line_up_informations(files)
  else
    line_up_files(files)
  end
end

def options
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
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
  output_files = []
  files_with_spaces.each_slice(rows) { |file| output_files << file }
  output_files = output_files.transpose
  output(output_files)
end

def output(output_files)
  output_files.each do |file|
    file.each { |filename| print filename }
    puts "\n"
  end
end

def line_up_informations(files)
  informations = files.map { |file_name| File.absolute_path("./#{file_name}") }.map { |full_path| File.lstat(full_path) }
  file_informations = Hash[*[files, informations].transpose.flatten]
  adjust_file_length(file_informations)
end

def adjust_file_length(file_informations)
  arrange_informations = file_informations
  link_length = arrange_informations.each_value.max_by { |file| file.nlink.to_s.size }.nlink.to_s.size + L_OPTION_PADDING
  uid_length = Etc.getpwuid(arrange_informations.each_value.max_by { |file| Etc.getpwuid(file.uid).name.size }.uid).name.size + L_OPTION_PADDING
  gid_length = Etc.getgrgid(arrange_informations.each_value.max_by { |file| Etc.getgrgid(file.gid).name.size }.gid).name.size + L_OPTION_PADDING
  size_length = arrange_informations.each_value.max_by { |file| file.size.to_s.size }.size.to_s.size + L_OPTION_PADDING
  output_file_info(arrange_informations, link_length, uid_length, gid_length, size_length)
end

def output_file_info(arrange_informations, link_length, uid_length, gid_length, size_length)
  puts "total #{arrange_informations.each_value.sum(&:blocks)}"
  arrange_informations.each do |file_name, file_info|
    print FILETYPES[file_info.ftype]
    (-3..-1).each { |num| print PERMISSION_NUMBERS[file_info.mode.to_s(8)[num].to_i] }
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

run_ls_with_options
