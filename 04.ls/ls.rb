# frozen_string_literal: true

FILES = Dir.glob('*').sort

def file_column
  filename_sizes = []
  FILES.each do |file|
    filename_sizes << file.size
  end
  (filename_sizes.max / 8 + 1) * 8
end

def current_column
  max_column = 3
  terminal_column = `tput cols`.chomp.to_i
  file_column * max_column > terminal_column ? terminal_column / file_column : max_column
end

files_size = FILES.size
d = (files_size % current_column).zero? ? files_size / current_column : files_size / current_column + 1

arrays = []
(1..d).each { |n| arrays << n.step(by: d, to: files_size).to_a }

arrays.each do |array|
  array.each do |i|
    print FILES[i - 1].ljust(file_column, ' ')
  end
  puts
end
