#!/usr/bin/env ruby
# frozen_string_literal: true

def get_the_list
  #elements = Dir.children('.').sort
  elements = Dir.glob("*").sort
  @elements = elements
end

def computes_numbers(max_columns_number)
  longest_name_size = @elements.max_by { |w| w.size }.size

  display_width =  `tput cols`

  minus_row = 0
  until longest_name_size < display_width.to_i / (max_columns_number - minus_row) do
    minus_row += 1
    break minus_row = max_columns_number - 1
  end

  decided_row_number = max_columns_number - minus_row

  decided_row_width = display_width.to_i / (decided_row_number) 
  @decided_row_width = decided_row_width

  n = @elements.size
  vertical_elements = 
  if n % decided_row_number == 0
    n / decided_row_number
  else
    n / decided_row_number + 1
  end
  @vertical_elements = vertical_elements
end

def processing_for_display
  elements_with_blank = @elements.map { |d| d.ljust(@decided_row_width) }

  slice_elements = []
  elements_with_blank.each_slice(@vertical_elements) { |slice_element| slice_elements << slice_element }
  
  slice_elements_with_nil = slice_elements.map { |element| element.values_at(0...@vertical_elements) }
  
  transpose_elements = slice_elements_with_nil.transpose.each { |display| puts display.join('')}
end

get_the_list
computes_numbers(3)
processing_for_display
