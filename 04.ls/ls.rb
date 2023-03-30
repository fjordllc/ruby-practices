#!/usr/bin/env ruby

def calculation_row(column, files)
  row = files.count / column
  row + 1 if files.count % column != 0
end

def ls(column, files)
  row = calculation_row(column, files)
  row.times do |r|
    columns = (0...column).map { |n| files[row * n + r] }
    columns.each do |c|
      print c&.ljust(40)
    end
    puts
  end
end

files = Dir.glob('*')
ls(4, files)
