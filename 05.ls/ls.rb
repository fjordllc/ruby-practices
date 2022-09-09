# frozen_string_literal: true

require 'optparse'

# options and description of them
options = ARGV.getopts('a')

COLUMN = 3
file_names = Dir.glob('*')
file_length_max = file_names.map(&:size).max
group_size = file_names.size / COLUMN + 1

file_groups = file_names.map { |fname| fname.ljust(file_length_max) }.each_slice(group_size).to_a

(0..group_size).each do |gs|
  (0..file_groups.size - 1).each do |row|
    print "#{file_groups[row][gs]} "
  end
  puts ''
end

