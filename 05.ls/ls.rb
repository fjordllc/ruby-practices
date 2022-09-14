# frozen_string_literal: true

require 'optparse'

# options and description of them
options = ARGV.getopts('a',
                       'all(-a)    list all files including hidden files.')

# columns to display on the screen
COLUMN = 3

def file_names(option)
  if option # option a
    Dir.glob('*', File::FNM_DOTMATCH)
  else
    Dir.glob('*')
  end
end

def file_length_max(file_name)
  file_name.map(&:size).max
end

def group_size(file_name)
  file_name.size / COLUMN + 1
end

def file_groups(file_name)
  file_name
    .sort
    .map { |fname| fname.ljust(file_length_max) }
    .each_slice(group_size)
    .to_a
end

(0..group_size).each do |gs|
  (0..file_groups.size - 1).each do |row|
    print "#{file_groups[row][gs]} "
  end
  puts '' unless gs == group_size
end
