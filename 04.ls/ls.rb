# frozen_string_literal: true

require 'optparse'

PARAMS = ARGV.getopts('a')

def files
  if PARAMS['a']
    Dir.glob('*', File::FNM_DOTMATCH).sort
  else
    Dir.glob('*').sort
  end
end

def file_column
  filename_sizes = files.map(&:size)
  (filename_sizes.max / 8 + 1) * 8
end

MAX_COLUMN = 3
def current_column
  terminal_column = `tput cols`.chomp.to_i
  file_column * MAX_COLUMN > terminal_column ? terminal_column / file_column : MAX_COLUMN
end

files_size = files.size
d = (files_size % current_column).zero? ? files_size / current_column : files_size / current_column + 1

arrays = (1..d).map { |n| n.step(by: d, to: files_size).to_a }

arrays.each do |array|
  array.each { |i| print files[i - 1].ljust(file_column, ' ') }
  puts
end
