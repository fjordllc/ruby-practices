#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
require 'optparse'

COLUMNS = 3
SPACE_FOR_COLUMNS = 2
def make_file_list(path)
  Dir.glob('*', base: path)
end

def make_disp_lines(path)
  files = make_file_list(path).sort
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
    if max_file_names[now_column] < file_name_size
      max_file_names[now_column] = file_name_size 
    end
  end
  add_space_for_line(lines, max_file_names)
end

def add_space_for_line(lines, max_file_names)
  result = []
  lines.each do |file_names|
    disp_line = ''
    file_names.each_with_index do |file_name, i|
      disp_line += file_name + ' ' * (max_file_names[i] - calc_file_name_size(file_name) + SPACE_FOR_COLUMNS)
    end
    result << disp_line
  end
  result
end

def calc_file_name_size(file_name)
  count = 0
  file_name.each_char do |char|
    count += char.ascii_only? ? 1 : 2
  end
  count
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

def make_disp_str(argv)
  result = []
  if argv == []
    make_disp_lines(Dir.pwd).each do |line|
      result << line
    end
  else
    _options, paths = split_option_or_path(argv)
    paths.each do |path|
      result << "#{path}:" if paths.size > 1
      make_disp_lines(path).each { |line| result << line }
    end
    result
  end
end

puts make_disp_str(parse_option)
