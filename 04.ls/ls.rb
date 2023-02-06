# frozen_string_literal: true

NUMBER_OF_COLUMNS = 3
LENGTH_OFFSET = 2

files = Dir.glob('*')

max_row_length = (files.length % NUMBER_OF_COLUMNS).zero? ? files.length / NUMBER_OF_COLUMNS : files.length / NUMBER_OF_COLUMNS + 1
file_names = files.each_slice(max_row_length).to_a

lengths = file_names.map do |file_name|
  file_name.max_by(&:length).length
end

max_row_length.times do |row|
  file_names.length.times do |col|
    print format("%-#{lengths[col] + LENGTH_OFFSET}s", file_names[col][row])
  end
  puts
end
