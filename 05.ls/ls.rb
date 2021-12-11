# frozen_string_literal: true

def print_files(path)
  files = path ? Dir.entries(path).sort : Dir.entries('.').sort
  files = files.drop(2)
  number = (files.length / 3).to_i + 2
  tab_files = files.each_slice(number).to_a
  (0..(number-1)).each do |i|
    lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
    puts lines.join('') if lines.any?
  end
end

print_files(ARGV[0])
