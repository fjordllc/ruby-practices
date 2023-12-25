#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COL_MAX = 3
PADDING = 2
FILE_TYPE_TO_CHARACTER = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's',
  'unknown' => '?'
}

def main
  options = { l: false }
  opt = OptionParser.new
  opt.on('-l') { options[:l] = true }
  argv = opt.parse(ARGV)

  path = argv[0] || './'
  # pathの文字列が/で終わらない場合、文字列の末尾に/を追加する
  corrected_path = path.sub(%r{([^/])\z}, '\1/')
  FileTest.directory?(corrected_path) or return
  file_names = Dir.children(corrected_path).sort
  filtered_file_names = file_names.reject { |name| name.start_with?('.') }
  options[:l] ? display_file_names_with_long(corrected_path, filtered_file_names) : display_file_names(filtered_file_names)
end

def display_file_names_with_long(path, file_names)
  # column_name_to_width = {}
  # column_name_to_width[:hard_link_numbers] = get_hard_link_numbers_width(file_names)
  file_names.each do |file_name|
    display_file_type(path, file_name)
    puts
  end
end

def display_file_type(path, file_name)
  file_type = File.ftype(path + file_name)
  print FILE_TYPE_TO_CHARACTER[file_type]
end

def display_file_names(file_names)
  total_file_names = file_names.size.to_f
  row_size = (total_file_names / COL_MAX).ceil
  col_size = (total_file_names / row_size).ceil
  widths = get_column_widths(file_names, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = file_names[row + col * row_size]
      width = widths[col] + PADDING
      print file_name.ljust(width, ' ') if file_name
    end
    puts
  end
end

def get_column_widths(file_names, row_size, col_size)
  widths = Array.new(col_size, 0)
  file_names.each.with_index do |file_name, index|
    column_index = index / row_size
    widths[column_index] = file_name.length if file_name.length > widths[column_index]
  end
  widths
end

main
