# frozen_string_literal: true

require 'optparse'

# options and description of them
options = ARGV.getopts('a',
                       'all(-a)    list all files including hidden files.')

# columns to display on the screen
COLUMN_MAX = 3

def file_names(option)
  if option == option['a'] # option a
    Dir.glob('*', File::FNM_DOTMATCH)
  else
    Dir.glob('*')
  end
end

def file_length_max(file_name)
  file_name.map(&:size).max
end

def group_size(file_name)
  file_name.size / COLUMN_MAX + 1
end

def divide_into_groups(file_name)
  file_name
    .sort
    .map { |fname| fname.ljust(file_length_max(file_name)) }
    .each_slice(group_size(file_name))
    .to_a
end

def list_files(file_names)
  group_in_groups = divide_into_groups(file_names)
  column = group_in_groups.size - 1
  row = group_size(file_names)
  (0..row).each do |r|
    (0..column).each do |c|
      print "#{group_in_groups[c][r]} "
    end
    puts '' unless r == row
  end
end
