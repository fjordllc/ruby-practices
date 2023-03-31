#!/usr/bin/env ruby

def calculation_row(column, files)
  files.count.ceildiv(column)
end

def ls(column, files)
  row = calculation_row(column, files)
  row.times do |r|
    (0...column).each { |c| print files[r + row * c]&.ljust(40) }
    puts
  end
end

files = Dir.glob('*')
ls(3, files)
