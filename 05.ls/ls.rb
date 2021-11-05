# frozen_string_literal: true

def build_display_column
  files = Dir.glob("*")
  display_column_size = (files.size / 3.0).ceil
  devided_columns = []
  files.each_slice(display_column_size) {|a| devided_columns << a}
  adjusted_columns = [] 
  devided_columns.each_with_index do |column, i|
    max_str_count = column.max_by {|v| v.size}.size
    adjusted_columns << column.map {|v| v.ljust(max_str_count + 2)}
  end
  
  if adjusted_columns.last.size != display_column_size
    empty_column_data_size = display_column_size - adjusted_columns.last.size
    count = 0
    while count < empty_column_data_size
      adjusted_columns.last << ''
      count += 1
    end
  end
  adjusted_columns.flatten
end

def display_files
  files = Dir.glob("*")
  display_column_size = (files.size / 3.0).ceil
  (0...display_column_size).each.with_index do |n|
    row = build_display_column.select.with_index { |_, i| i % display_column_size == n }
    row.each.with_index {|row_data, i| print i % 3 == 2 ? "#{row_data}\n" : row_data}
  end
end

display_files