#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'etc'
require 'optparse'

def convert_file_type(str)
  table = {
    'socket' => 's',
    'link' => 'l',
    'file' => '-',
    'block device' => 'b',
    'directory' => 'd',
    'character device' => 'c',
    'FIFO' => 'p'
  }
  table[str]
end

def convert_permition(str)
  table = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }
  table[str]
end

def details(files, path)
  details = []
  files.each do |f|
    detail = {}
    stat = File.stat("#{path}/#{f}")
    file_mode = stat.mode.to_s(8).chars
    detail[:file_type] = convert_file_type(stat.ftype)
    detail[:permition] = [convert_permition(file_mode[-3]), convert_permition(file_mode[-2]), convert_permition(file_mode[-1])].join
    detail[:hardlinks] = stat.nlink
    detail[:owner] = Etc.getpwuid(stat.uid).name
    detail[:group] = Etc.getgrgid(stat.gid).name
    detail[:bytes] = stat.size
    detail[:year] = stat.ctime.year
    detail[:month] = stat.ctime.month
    detail[:day] = stat.ctime.day
    detail[:time] = stat.ctime.strftime('%R')
    detail[:name] = f
    detail[:blocks] = stat.blocks
    details << detail
  end
  details
end

def ls(path, params)
  files = Dir.entries(path).sort
  files.delete_if { |f| f.match?(/^\./) } unless params[:a]
  files.reverse! if params[:r]
  if params[:l]
    details(files, path)
  else
    files
  end
end

def pretty_print(files)
  if files.first.class.name == 'Hash'
    print_detail(files)
  else
    print_names(files)
  end
end

def convert_detail(file, max_length)
  [
    file[:file_type],
    file[:permition],
    ' ',
    file[:hardlinks].to_s.rjust(max_length[:hardlinks], ' '),
    ' ',
    file[:owner].ljust(max_length[:owner], ' '),
    '  ',
    file[:group].ljust(max_length[:group], ' '),
    '  ',
    file[:bytes].to_s.rjust(max_length[:bytes], ' '),
    ' ',
    file[:month].to_s.rjust(2, ' '),
    ' ',
    file[:day].to_s.rjust(2, ' '),
    ' ',
    (Date.today << 6) < Date.new(file[:year], file[:month], file[:day]) ? file[:time] : file[:year].to_s.rjust(5, ' '),
    ' ',
    file[:name]
  ].join
end

def print_detail(files)
  total_blocks = 0
  max_length = {
    hardlinks: 0,
    owner: 0,
    group: 0,
    bytes: 0
  }
  files.each do |f|
    total_blocks += f[:blocks]
    max_length.keys.each do |x|
      max_length[x] = f[x].to_s.length if f[x].to_s.length > max_length[x]
    end
  end
  puts "total #{total_blocks}"
  files.each do |f|
    puts convert_detail(f, max_length)
  end
end

def print_names(files)
  window_size_cols = `tput cols`.to_i
  max_length_file_name = files.max_by(&:length)
  colums = window_size_cols / (max_length_file_name.size + 1)
  rows = (files.size.to_f / colums).ceil
  tables = files.each_slice(rows).to_a
  tables[0].length.times do |y|
    tables.length.times do |x|
      if tables[x][y].nil?
        item_name = ''.ljust(max_length_file_name.size + 1, ' ')
      else
        ascii_chars = tables[x][y].chars.select(&:ascii_only?)
        multi_byte_chars = tables[x][y].size - ascii_chars.size
        item_name = tables[x][y].ljust(max_length_file_name.size + 1 - multi_byte_chars, ' ')
      end
      print item_name
    end
    puts
  end
end

params = {}
opt = OptionParser.new
opt.on('-a') { |v| params[:a] = v }
opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }

opt.permute!(ARGV)
target_path = ARGV != [] ? File.expand_path(ARGV.first) : File.expand_path('.')
pretty_print(ls(target_path, params))
