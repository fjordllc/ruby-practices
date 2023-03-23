#!/usr/bin/env ruby

def calculation_row(column, files)
  if files.count % column != 0
    files.count / column + 1
  else
    files.count / column
  end
end

def ls(column, files)
  row = calculation_row(column, files)
  row.times do |r|
    columns = (0..column - 1).map { |n| files[(row - r) * n] }
    files -= columns
    (0..column - 1).each do |c|
      columns[c] ||= ''
      print columns[c].ljust(40)
    end
    puts "\n"
  end
end

files = Dir.glob('*')
ls(3, files)
