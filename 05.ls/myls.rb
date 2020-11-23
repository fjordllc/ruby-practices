#!/usr/bin/env ruby

class List
  def initialize

  end
end

other_files = Dir.glob("*")
other_files.sort!

i = 0
other_files.each do |f|
  print f.ljust(16)
  i += 1
  if i % 3 == 0
    puts ''
  end
end
