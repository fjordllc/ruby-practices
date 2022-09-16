# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('l',
                       'long format(-l)  use a long listing format.')

# columns to display on the screen
COLUMN_MAX = 3

def count_group_size(file_names)
  file_names.size / COLUMN_MAX + 1
end

def divide_into_groups(file_names)
  file_names
    .map { |fname| fname.ljust(file_names.map(&:size).max) }
    .each_slice(count_group_size(file_names))
    .to_a
end

def list_files(file_names)
  file_names_in_groups = divide_into_groups(file_names)
  column = file_names_in_groups.size - 1
  row = count_group_size(file_names)
  (0..row).each do |r|
    (0..column).each do |c|
      print "#{file_names_in_groups[c][r]} "
    end
    puts '' unless r == row
  end
end

def count_blocks(file_names)
  number_of_files = file_names.size - 1
  (0..number_of_files).map do |nf|
    fs = File::Stat.new(file_names[nf])
    fs.blocks / 2
  end.sum
end

def list_files_in_long_format(file_names)
  number_of_files = file_names.size - 1
  print 'total '
  puts count_blocks(file_names)
  (0..number_of_files).each do |nf|
    fs = File::Stat.new(file_names[nf])
    print fs.mode.to_s(8)
    print " "
    print fs.nlink
    print " "
    print Etc.getpwuid(fs.uid).name
    print " "
    print Etc.getgrgid(fs.gid).name
    print " "
    print fs.size
    print " "
    print fs.mtime
    print " "
    puts file_names[nf]
  end
end

if options['l']
  list_files_in_long_format(Dir.glob('*'))
else
  list_files(Dir.glob('*'))
end
