#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'

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
}.freeze
PERMISSION_SEPARATOR = 512

def main
  options = { a: false, r: false, l: false }
  path = './'
  ARGV.each do |argv|
    if FileTest.directory?(argv)
      path = argv
    elsif argv.start_with?('-')
      specified_options = argv.delete('-').chars
      specified_options.each do |specified_option|
        case specified_option
        when 'a' then options[:a] = true
        when 'r' then options[:r] = true
        when 'l' then options[:l] = true
        end
      end
    end
  end

  file_names = get_filtered_file_names(path, options)
  options[:l] ? display_file_names_with_long(path, file_names) : display_file_names(file_names)
end

def get_filtered_file_names(path, options)
  file_names = Dir.glob('*', File::FNM_DOTMATCH, base: path).sort_by { |name| name.delete('.') }
  filtered_file_names = options[:a] ? file_names : file_names.reject { |name| name.start_with?('.') }
  options[:r] ? filtered_file_names.reverse : filtered_file_names
end

def display_file_names_with_long(path, file_names)
  file_paths = file_names.map { |file_name| File.join(path, file_name) }
  total_block_size = file_paths.sum { |file_path| File.stat(file_path).blocks }
  puts "total #{total_block_size / 2}"

  file_paths.each do |file_path|
    file_type = File.ftype(file_path)
    stat = File.stat(file_path)
    mode = get_mode_by_stat(stat)
    widths = calc_widths(file_paths)
    cols = []
    cols << FILE_TYPE_TO_CHARACTER[file_type] + mode
    cols << stat.nlink.to_s.rjust(widths[:nlink])
    cols << get_owner_name(stat).ljust(widths[:owner])
    cols << get_group_name(stat).ljust(widths[:group])
    cols << stat.size.to_s.rjust(widths[:size])
    cols << stat.mtime.strftime('%b %e %H:%M')
    cols << File.basename(file_path)
    puts cols.join(' ')
  end
end

def get_mode_by_stat(stat)
  mode = ''
  mode_number = stat.mode % PERMISSION_SEPARATOR
  binary_modes = mode_number.digits(2).reverse
  binary_modes.each.with_index do |binary_mode, index|
    case index % 3
    when 0 then mode += binary_mode == 1 ? 'r' : '-'
    when 1 then mode += binary_mode == 1 ? 'w' : '-'
    when 2 then mode += binary_mode == 1 ? 'x' : '-'
    end
  end
  mode
end

def calc_widths(file_paths)
  widths = { nlink: 0, owner: 0, group: 0, size: 0 }
  file_paths.each do |file_path|
    stat = File.stat(file_path)
    widths[:nlink] = [widths[:nlink], stat.nlink.to_s.length].max
    widths[:owner] = [widths[:owner], get_owner_name(stat).length].max
    widths[:group] = [widths[:group], get_group_name(stat).length].max
    widths[:size] = [widths[:size], stat.size.to_s.length].max
  end
  widths
end

def get_owner_name(stat)
  Etc.getpwuid(stat.uid).name
end

def get_group_name(stat)
  Etc.getpwuid(stat.gid).name
end

def display_file_names(file_names)
  file_count = file_names.size.to_f
  row_size = (file_count / COL_MAX).ceil
  col_size = (file_count / row_size).ceil
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
