# frozen_string_literal: true

def files
  Dir.glob('*').map do |list|
    list
  end
end

def columns_list
  columns = 3
  lists = files
  rest_row = lists.size % columns
  if rest_row != 0
    (columns - rest_row).times do
      lists << nil
    end
  end
  rows = lists.size / columns
  lists.each_slice(rows).to_a
end

def displays(file_lists)
  file_lists.each do |index|
    index.each do |item|
      print item.to_s.ljust(10)
    end
    puts "\n"
  end
end
displays(columns_list.transpose)
