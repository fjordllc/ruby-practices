#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMNS = 3

directory_path = ARGV[0] || '.'

def get_file(path)
  Dir.glob('*', base: path, sort: true)
end

def get_max_length(files_and_directories)
  files_and_directories.map(&:length).max
end

def organizing_arrays(files_and_directories, columns, output_num)
  outputs = Array.new(columns) { [] }

  array_num = 0
  files_and_directories.sort.each do |item|
    outputs[array_num] << item
    array_num += 1 if (outputs[array_num].length % output_num).zero?
  end
  outputs
end

def output_file(output_num, columns, file_name_length, files_and_directories)
  output_num.times do |time|
    columns.times do |column|
      print files_and_directories[column][time]
      print ' ' * (file_name_length - files_and_directories[column][time].to_s.length + 1)
    end
    puts "\n"
  end
end
temporary_outputs = get_file(directory_path)
max_file_length = get_max_length(temporary_outputs)
# 一列に出力するファイルの数
maximum_num = temporary_outputs.length / COLUMNS + 1
outputs = organizing_arrays(temporary_outputs, COLUMNS, maximum_num)
output_file(maximum_num, COLUMNS, max_file_length, outputs)
