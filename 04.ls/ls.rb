# !/usr/bin/env ruby
# frozen_string_literal: true

def list_files(directory, columns)
  files = Dir.entries(directory) - ['.', '..']
  print_files(files, columns)
end

def print_files(files, columns)
  files.each_slice(columns) do |slice|
    puts slice.map { |file| file.ljust(20) }.join(' ')
  end
end

list_files(Dir.pwd, 3)
