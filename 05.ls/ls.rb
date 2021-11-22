# frozen_string_literal: true

def calc_file_count_per_column(files, column_count)
  (files.size / column_count).ceil
end

def build_display_column
  column_count = 3.0
  current_directory_files = Dir.glob('*')

  file_count_per_column = calc_file_count_per_column(current_directory_files, column_count)
  divided_files = current_directory_files.each_slice(file_count_per_column).to_a

  adjusted_file_list = []
  divided_files.each do |column|
    max_str_count = column.max_by(&:size).size
    adjusted_file_list << column.map { |v| v.ljust(max_str_count + 2) }
  end

  last_column = adjusted_file_list.last
  (file_count_per_column - last_column.size).times { last_column << '' }

  adjusted_file_list.transpose
end

def display_files
  build_display_column.each do |list|
    list.each do |value|
      suffix = "\n"
      if value == list.last
        print "#{value}#{suffix}"
      else
        print value
      end
    end
  end
end

display_files
