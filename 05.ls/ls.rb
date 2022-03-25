#!/usr/bin/env ruby
# frozen_string_literal: true

def array_sort(array)
  width = 3
  height = (array.size.to_f / width).ceil

  array = array.each_slice(height).to_a

  ans = []

  height.times do |row|
    num = []
    width.times do |column|
      num << (array[column][row])
    end
    ans << num
  end
  ans
end
