# frozen_string_literal: true

require 'optparse'

# options and description of them
options = ARGV.getopts('a',
                       'all(-a)    list all files including hidden files.')

# columns to display on the screen
COLUMN_MAX = 3

def count_group_size(array)
  array.size / COLUMN_MAX + 1
end

def divide_into_groups(array)
  array
    .sort
    .map { |a| a.ljust(array.map(&:size).max) }
    .each_slice(count_group_size(array))
    .to_a
end

def list_files(file_names)
  group_in_groups = divide_into_groups(file_names)
  column = group_in_groups.size - 1
  row = count_group_size(file_names)
  (0..row).each do |r|
    (0..column).each do |c|
      print "#{group_in_groups[c][r]} "
    end
    puts '' unless r == row
  end
end

if options['a']
  list_files(Dir.glob('*', File::FNM_DOTMATCH))
else
  list_files(Dir.glob('*'))
end
