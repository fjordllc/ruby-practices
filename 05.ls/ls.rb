# frozen_string_literal: true

def print_files(path)
  files = path ? Dir.children(path).sort : Dir.children('.').sort
  number = calculate_number(files.length)
  tab_files = files.each_slice(number).to_a
  index = number - 1
  (0..index).each do |i|
    lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
    puts lines.join('') if lines.any?
  end
end

def calculate_number(length)
  return 4 if length < 40

  multiplier = length % 40
  multiplier.zero? ? 4 : multiplier * 2
end

print_files(ARGV[0])
