# frozen_string_literal: true

current_path = ARGV[0].nil? ? __dir__ : ARGV[0]

def empty_space_length(filename)
  40 - filename.length
end

def formatted_print(current_file)
  print(current_file + ' ' * empty_space_length(current_file))
end

file_list = Dir.glob("#{current_path}/*")

0.upto(file_list.length - 1) do |index|
  formatted_print(File.basename(file_list[index]))
  puts '' if ((index + 1) % 3).zero?
end

puts ''
