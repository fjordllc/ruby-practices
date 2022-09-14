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

def file_groups(file_name)
  file_name
    .sort
    .map { |fname| fname.ljust(file_length_max) }
    .each_slice(group_size)
    .to_a
end

def list_files(column, row)
  (0..row).each do |r|
    (0..column.size - 1).each do |c|
      print "#{file_groups[c][r]} "
    end
    puts '' unless r == row
  end
end
