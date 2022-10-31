#!/usr/bin/env ruby
# frozen_string_literal: true

def make_list
  Dir.glob('*').sort
end

def display_width
  `tput cols`
end

def columns_number
  max_columns = 3

  longest_name_size = make_list.max_by(&:size).size

  minus_columns = 0
  while longest_name_size > display_width.to_i / (max_columns - minus_columns)
    minus_columns += 1
    break if minus_columns == max_columns - 1
  end
  max_columns - minus_columns
end

def columns_width
  display_width.to_i / columns_number
end

def vertical
  n = make_list.size
  calc_vertical = n / columns_number
  if (n % columns_number).zero?
    calc_vertical
  else
    calc_vertical + 1
  end
end

def display_result
  left_alignment = make_list.map { |d| d.ljust(columns_width) }
  slice = left_alignment.each_slice(vertical).to_a
  add_nil = slice.map { |element| element.values_at(0...vertical) }
  add_nil.transpose.each { |display| puts display.join('') }
end

display_result
