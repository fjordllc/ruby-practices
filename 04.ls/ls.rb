# frozen_string_literal: true

def display_files(files)
  column_count = 3
  rows = (files.length + column_count - 1) / column_count
  max_length = files.map(&:length).max

  rows.times do |row|
    print_row(files, row, rows, max_length, column_count)
    puts
  end
end

def print_row(files, row, rows, max_length, column_count)
  column_count.times do |column|
    index = column * rows + row
    if files[index]
      if files[(column + 1) * rows + row]
        print files[index].ljust(max_length + 2)
      else
        print files[index]
      end
    end
  end
end

files = Dir.glob('*')
display_files(files)
