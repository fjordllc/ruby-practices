#!/usr/bin/env ruby

entries = Dir.glob("*", base: Dir.getwd)
max_line = (entries.count / 3.to_f).ceil

entries.each_with_index do |e,i|
    puts "#{entries[i].ljust(20)} #{entries[i + max_line].ljust(20)} #{entries[i + (max_line * 2)]}" if i < max_line
end
