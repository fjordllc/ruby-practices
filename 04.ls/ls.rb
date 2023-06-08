#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

opts = OptionParser.new
params = {}
opts.on('-l') { |v| params[:l] = v }
opts.parse!(ARGV)

COLUMNS = 3


directory_path = ARGV[0] || '.'

def get_file(path)
  Dir.glob('*', base: path, sort: true)
end

def get_details(files_and_directories, options)
  byte_length = 5
  files_and_directories.map! do |files_and_directorie|
    details_files_and_directorie = {}
    if options[:l]
      permission = ''
      file_type = File::Stat.new(files_and_directorie).ftype
      permission += '-' if file_type == 'file'
      permission += 'd' if file_type == 'directory'
      permission += 'c' if file_type == 'characterSpecial'
      permission += 'f' if file_type == 'fifo'
      permission += 'l' if file_type == 'link'
      permission += 's' if file_type == 'socket'
      permission_base_eight = File::Stat.new(files_and_directorie).mode.to_s(8)
      three_digit = permission_base_eight[(permission_base_eight.length.to_i - 3) ... permission_base_eight.to_i]
      three_digit.each_char do |c|
        permission += '---' if c == '0'
        permission += '--x' if c == '1'
        permission += '-w-' if c == '2'
        permission += '-wx' if c == '3'
        permission += 'r--' if c == '4'
        permission += 'r-x' if c == '5'
        permission += 'rw-' if c == '6'
        permission += 'rwx' if c == '7'
      end
      details_files_and_directorie[:permission] = permission
      details_files_and_directorie[:links] = " " + File::Stat.new(files_and_directorie).nlink.to_s
      details_files_and_directorie[:owner] = " " + Etc.getpwuid(File::Stat.new(files_and_directorie).uid).name
      details_files_and_directorie[:group] = " " + Etc.getgrgid(File::Stat.new(files_and_directorie).gid).name
      details_files_and_directorie[:byte_size] = " " +  File::Stat.new(files_and_directorie).size.to_s.rjust(byte_length)
      details_files_and_directorie[:time] = " " + File::Stat.new(files_and_directorie).mtime.strftime("%m %d %H:%M") + " "
    end
    details_files_and_directorie[:name] = files_and_directorie
    details_files_and_directorie
  end
end

def get_max_length(files_and_directories)
  files_and_directories.map{ |files_and_directorie| files_and_directorie[:name].length }.max
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

def output_file(output_num, columns, files_and_directories, options)
  puts "total #{files_and_directories.flatten.length}" if options[:l]
  output_num.times do |time|
    files_and_directories[time].length.times do |column|
      if options[:l]
        files_and_directories[column][time].each do |key, value|
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
temporary_outputs = get_details(temporary_outputs, params)
max_file_length = get_max_length(temporary_outputs)
# # 一列に出力するファイルの数
maximum_num = temporary_outputs.length / COLUMNS + 1
outputs = organizing_arrays(max_file_length, temporary_outputs, COLUMNS, maximum_num)
output_file(maximum_num, COLUMNS, outputs, params)
