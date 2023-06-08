#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

opts = OptionParser.new
params = {}
opts.on('-l') { |v| params[:l] = v }
opts.parse!(ARGV)

COLUMNS = 3
BYTE_LENGTH = 5
directory_path = ARGV[0] || '.'

def get_file(path)
  Dir.glob('*', base: path, sort: true)
end

FILE_TYPE = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'fifo' => 'f',
  'link' => 'l',
  'socket' => 's'
}.freeze

FILE_PERMISSION = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def get_details(files_and_directories, options, byte_length, type, permission_type)
  files_and_directories.map! do |files_and_directorie|
    details_files_and_directorie = {}
    if options[:l]
      permission = ''
      file_type = File::Stat.new(files_and_directorie).ftype
      permission += type[file_type]
      permission_base_eight = File::Stat.new(files_and_directorie).mode.to_s(8)
      three_digit = permission_base_eight[(permission_base_eight.length.to_i - 3)...permission_base_eight.to_i]
      three_digit.each_char { |c| permission += permission_type[c] }
      details_files_and_directorie[:permission] = permission
      file_stat = File::Stat.new(files_and_directorie)
      details_files_and_directorie[:links] = file_stat.nlink.to_s.rjust(file_stat.nlink.to_s.length.to_i + 1)
      details_files_and_directorie[:owner] = Etc.getpwuid(file_stat.uid).name.rjust(Etc.getpwuid(file_stat.uid).name.length.to_i + 1)
      details_files_and_directorie[:group] = Etc.getgrgid(file_stat.gid).name.rjust(Etc.getgrgid(file_stat.gid).name.length.to_i + 1)
      details_files_and_directorie[:byte_size] = file_stat.size.to_s.rjust(byte_length + 1)
      details_files_and_directorie[:time] = file_stat.mtime.strftime('%m %d %H:%M').center(file_stat.mtime.strftime('%m %d %H:%M').length + 2)
    end
    details_files_and_directorie[:name] = files_and_directorie
    details_files_and_directorie
  end
end

def get_max_length(files_and_directories)
  files_and_directories.map { |files_and_directorie| files_and_directorie[:name].length }.max
end

def organizing_arrays(file_name_length, files_and_directories, columns, output_num)
  outputs = Array.new(columns) { [] }
  array_num = 0
  files_and_directories.each do |item|
    item[:name] = item[:name].ljust(file_name_length * 2 - item[:name].scan(/[^\x01-\x7E]/).size)
    outputs[array_num] << item
    array_num += 1 if (outputs[array_num].length % output_num).zero?
  end
  outputs
end

def output_file(output_num, files_and_directories, options)
  puts "total #{files_and_directories.flatten.length}" if options[:l]
  output_num.times do |time|
    files_and_directories[time].length.times do |column|
      if options[:l]
        files_and_directories[column][time].each do |_key, value|
          print value
        end
        puts "\n"
      else
        print files_and_directories[column][time][:name] unless files_and_directories[column][time].nil?
      end
    end
    puts "\n" unless options[:l]
  end
end

temporary_outputs = get_file(directory_path)
temporary_outputs = get_details(temporary_outputs, params, BYTE_LENGTH, FILE_TYPE, FILE_PERMISSION)
max_file_length = get_max_length(temporary_outputs)
# # 一列に出力するファイルの数
maximum_num = temporary_outputs.length / COLUMNS + 1
outputs = organizing_arrays(max_file_length, temporary_outputs, COLUMNS, maximum_num)
output_file(maximum_num, outputs, params)
