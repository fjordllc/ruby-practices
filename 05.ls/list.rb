#!/usr/bin/env ruby

def main
  directory = ARGV[0] || Dir.getwd
  max_row = 3
  segments = Dir.glob("*", base: directory)
  max_column = (segments.count / max_row.to_f).ceil
  print_segments(max_row, segments, max_column)
end

def print_segments(max_row, segments, max_column)
  columns = []
  segments.each_with_index do |s,i|
    if i < max_column
      column = []
      column << s.ljust(15)
      (1..max_row - 1).each do |r|
        column <<  segments[i + max_column * r].ljust(15) if i + max_column * r < segments.size
      end
      columns << column
    end
  end
  columns.each do |c|
    puts c.join("")
  end
end

main
