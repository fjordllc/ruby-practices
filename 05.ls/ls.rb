# frozen_string_literal: true

def row_column
  files = Dir.glob('*')
  column_count = 3
  rest_of_row_count = files.size % column_count
  if rest_of_row_count >= 1
    (column_count - rest_of_row_count).times do
      files << nil
    end
  end
  row_count = files.size / column_count
  files.each_slice(row_count).to_a
end

def display(column_row)
  column_row.each do |new_line|
    new_line.each do |right_align|
      print right_align.to_s.ljust(10)
    end
    puts "\n"
  end
end
display(row_column.transpose)
