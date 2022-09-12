# frozen_string_literal: true

require 'optparse'

# options and description of them
options = ARGV.getopts('a',
'all(-a)    list all files including hidden files.')

COLUMN = 3

if options['a'] # option a
  file_names = Dir.glob('.*') + Dir.glob('*')
else
  file_names = Dir.glob('*')
end

def file_length_max
  file_names.map(&:size).max
end

def group_size
  file_names.size / COLUMN + 1
end

def file_groups
  file_names
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

