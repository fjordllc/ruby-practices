# frozen_string_literal: true

current_path = __dir__

def empty_space_length(filename)
  50 - filename.length
end

def formatted_print(current_file)
  print(current_file + ' ' * empty_space_length(current_file))
end

file_list = Dir.entries(current_path).select { |f| File.file? File.join(current_path, f) }

0.upto(file_list.length - 1) do |index|
  formatted_print(file_list[index])
  puts '' if ((index + 1) % 3).zero?
end

puts ''
