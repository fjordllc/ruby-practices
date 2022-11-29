#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
require 'optparse'

COLUMNS = 3
SPACE_FOR_COLUMNS = 2

def adjust_list_to_display(files)
  rows = (files.size.to_f / COLUMNS).ceil
  lines = []
  max_file_names = []
  files.each_with_index do |file_name, i|
    now_row = i % rows
    now_column = i / rows
    lines[now_row] = [] if now_column.zero?
    max_file_names[now_column] ||= 0

    lines[now_row] << file_name
    file_name_size = calc_file_name_size(file_name)
    max_file_names[now_column] = file_name_size if max_file_names[now_column] < file_name_size
  end
  add_space_for_line(lines, max_file_names)
end

def add_space_for_line(lines, max_file_names)
  result = []
  lines.each do |file_names|
    display_line = ''
    file_names.each_with_index do |file_name, i|
      display_line = "#{display_line}#{file_name}#{' ' * (max_file_names[i] - calc_file_name_size(file_name) + SPACE_FOR_COLUMNS) }"
    end
    result << display_line
  end
  result
end

def calc_file_name_size(file_name)
  file_name.each_char.sum do |char|
  char.ascii_only? ? 1 : 2
  end
end

def split_option_or_path(argv)
  options = {}
  paths = []
  argv.each do |str|
    if ['-a', '-r', '-l'].include?(str)
      options[str] = true
    else
      paths << str
    end
  end
  [options, paths]
end

def parse_option
  opt = OptionParser.new
  # TODO: オプションの説明追加
  opt.on('-a', '今後対応予定')
  opt.on('-r', '今後対応予定')
  opt.on('-l', '今後対応予定')
  opt.banner = 'Usage: ls [-a][-r][-l]'
  opt.parse(ARGV)
  ARGV
end

def make_display_list(argv)
  result = []
  if argv == []
    file_list = Dir.glob('*', base: Dir.pwd).sort
    adjust_list_to_display(file_list).each { |line| result << line }
  else
    _options, paths = split_option_or_path(argv)
    file_list = analyse_file_paths(paths)
    display_lines = adjust_list_to_display(file_list.sort)
    display_lines.each { |line| result << line }
    result << "\n" unless file_list == []
    directorys = analyse_directory_paths(paths)
    result.push(*directorys)
    result
  end
end

def analyse_directory_paths(paths)
  result = []
  paths.each do |path|
    next unless File::Stat.new(path).directory?

    result << "\n" unless result == []
    result << "#{path}:" if paths.size > 1
    file_list = Dir.glob('*', base: path).sort
    display_lines = adjust_list_to_display(file_list)
    display_lines.each { |line| result << line }
  end
  result
end

def analyse_file_paths(paths)
  paths.select { |path| File::Stat.new(path).file? }
end

puts make_display_list(parse_option)
