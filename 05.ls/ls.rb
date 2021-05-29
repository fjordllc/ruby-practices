#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main(option)
  directory = Dir.glob('*')
  directory.unshift(Dir.glob('.*')).flatten! if option['a']
  directory.reverse! if option['r']

  if option['l']
    option_l(directory)
  else
    arrange_without_option(directory)
  end
end

def option_l(directory)
  directory.each do |dir|
    file_stat = File::Stat.new(dir)
    file_stat_mode = file_stat.mode.to_s(8)
    file_type = file_stat_mode.length == 6 ? file_stat_mode[0, 3] : file_stat_mode[0, 2]
    file_permission = file_stat_mode.length == 6 ? file_stat_mode[3, 3] : file_stat_mode[2, 3]
    file_type_parse = file_type_table(file_type)
    file_permission_parse = file_permissions_table(file_permission[0]) + file_permissions_table(file_permission[1]) + file_permissions_table(file_permission[2])
    file_nlink = file_stat.nlink
    file_owner = Etc.getpwuid(file_stat.uid).name
    file_group = Etc.getgrgid(file_stat.gid).name
    file_size = file_stat.size
    timestamp = file_stat.mtime.strftime('%-m %e %H:%M')

    puts "#{file_type_parse}#{file_permission_parse}  #{file_nlink} #{file_owner}  #{file_group}   #{file_size}  #{timestamp} #{dir}"
  end
end

def file_type_table(file_type)
  {
    '20': 'c',
    '60': 'b',
    '40': 'd',
    '100': '-',
    '120': 'l'
  }[file_type.to_sym]
end

def file_permissions_table(file_type)
  {
    '0': '---',
    '1': '--x',
    '2': '-w-',
    '3': '-wx',
    '4': 'r--',
    '5': 'r-x',
    '6': 'rw-',
    '7': 'rwx'
  }[file_type.to_sym]
end

def arrange_without_option(directory)
  num_of_slice = (directory.count / 3.0).ceil

  directories = []
  directory.each_slice(num_of_slice) do |x|
    x << nil until x.size == num_of_slice
    directories << x
  end

  transeposed_directories = directories.transpose

  max_lengh_of_words = directory.max_by(&:length).length  # ファイル名が最長のファイルの単語数を取得

  num_of_row = transeposed_directories.count - 1
  num_of_col = 2

  (0..num_of_row).each do |row|
    (0..num_of_col).each do |col|
      print "#{transeposed_directories[row][col].ljust(max_lengh_of_words)}  " unless transeposed_directories[row][col].nil?
    end
    print "\n"
  end
end

option = ARGV.getopts('alr')
main(option)
