# frozen_string_literal: true

def print_files(path)
  files = path ? Dir.entries(path).sort : Dir.entries('.').sort
  files = files.drop(2)
  number = calculate_number(files.length)
  tab_files = files.each_slice(number).to_a
  index = number - 1
  (0..index).each do |i|
    line = ''
    (0..tab_files.length).each do |j|
      tab_file = tab_files[j]
      next unless tab_file && tab_file[i]

      line += tab_file[i].slice(0, 15).ljust(20)
    end
    puts line unless line == ''
  end
end

def calculate_number(length)
  return 4 if length < 40

  multiplier = length % 40
  multiplier.zero? ? 4 : multiplier * 2
end

print_files(ARGV[0])
