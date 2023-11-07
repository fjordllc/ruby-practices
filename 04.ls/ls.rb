#!/usr/bin/env ruby
# frozen_string_literal: true

# 表示列
DISPLAY_COLUMN = 3

def store_display(files)
  displays = setup_array(files)
  max_file_name_length = files.map(&:size).max
  cnt = 0
  catch :files_end do
    0...DISPLAY_COLUMN.times do |column|
      0...displays.size.times do |row|
        if column != DISPLAY_COLUMN - 1
          displays[row][column] = files[cnt].ljust(max_file_name_length + 1) if !files[cnt].nil?
        else
          displays[row][column] = files[cnt]
        end
        throw :files_end if cnt == files.size - 1
        cnt += 1
      end
    end
  end
  displays
end

def setup_array(files)
  quotient, remainder = files.size.divmod(DISPLAY_COLUMN)
  # ファイルの数に応じた2次元配列を用意
  row = if remainder.zero?
          quotient
        else
          quotient + 1
        end
  Array.new(row) { Array.new(DISPLAY_COLUMN, '') }
end

def output_display(displays)
  output_displays = Array.new(displays.size, '')
  0...displays.size.times do |row|
    0...DISPLAY_COLUMN.times do |column|
      output_displays[row] = output_displays[row] + displays[row][column]
    end
    puts output_displays[row]
  end
end

files = Dir.glob('*')
displays = store_display(files)
output_display(displays)
