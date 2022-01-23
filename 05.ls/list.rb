#!/usr/bin/env ruby

MAX_COLUMN = 3
COLUMN_WIDTH = 15

def main
  directory = ARGV[0] || Dir.getwd
  segments = sort_segments(directory)
  rows = create_rows(segments)
  list_segments(rows)
end

def sort_segments(directory)
  Dir.glob("*", base: directory)
end

def create_rows(segments)
  max_row = (segments.count / MAX_COLUMN.to_f).ceil
  rows = []
  segments.each_with_index do |s,i|
    if i < max_row
      row = []
      row << s.ljust(COLUMN_WIDTH)
      (1..MAX_COLUMN - 1).each do |r|
        row <<  segments[i + max_row * r].ljust(COLUMN_WIDTH) if i + max_row * r < segments.size
      end
      rows << row 
    end
  end
  rows
end

def list_segments(rows)
  rows.each do |c|
    puts c.join("")
  end
end

main
