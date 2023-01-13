# frozen_string_literal: true

require 'optparse'

params = ARGV.getopts('ar')
flags = params['a'] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags).sort
files.reverse! if params['r']

def file_column(files)
  filename_sizes = files.map(&:size)
  (filename_sizes.max / 8 + 1) * 8
end

MAX_COLUMN = 3
def current_column(files)
  terminal_column = `tput cols`.chomp.to_i
  file_column(files) * MAX_COLUMN > terminal_column ? terminal_column / file_column(files) : MAX_COLUMN
end

files_size = files.size
d = (files_size % current_column(files)).zero? ? files_size / current_column(files) : files_size / current_column(files) + 1
arrays = (1..d).map { |n| n.step(by: d, to: files_size).to_a }

arrays.each do |array|
  array.each { |i| print files[i - 1].ljust(file_column(files), ' ') }
  puts
end
