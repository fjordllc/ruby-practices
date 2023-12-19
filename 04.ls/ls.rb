#!/usr/bin/env ruby
# frozen_string_literal: true

COL_MAX = 3
PADDING = 2

def main
  path = '.'
  option_settings = { is_option_a_enabled: false }
  ARGV.each do |argv|
    case argv
    when '-a'
      option_settings[:is_option_a_enabled] = true
    else
      path = argv if FileTest.directory?(path)
    end
  end
  file_names = Dir.glob('*', File::FNM_DOTMATCH).sort_by { |name| name.delete('.') }
  display_file_names(file_names, option_settings)
end

def display_file_names(file_names, option_settings)
  filtered_file_names = if option_settings[:is_option_a_enabled]
                          file_names
                        else
                          file_names.reject { |name| name.start_with?('.') }
                        end
  total_file_names = filtered_file_names.size.to_f
  row_size = (total_file_names / COL_MAX).ceil
  col_size = (total_file_names / row_size).ceil
  widths = get_column_widths(filtered_file_names, row_size, col_size)

  row_size.times do |row|
    col_size.times do |col|
      file_name = filtered_file_names[row + col * row_size]
      width = widths[col] + PADDING
      print file_name.ljust(width, ' ') if file_name
    end
    puts
  end
end

def get_column_widths(file_names, row_size, col_size)
  widths = Array.new(col_size, 0)
  file_names.each.with_index do |file_name, index|
    column_index = index / row_size
    widths[column_index] = file_name.length if file_name.length > widths[column_index]
  end
  widths
end

main
