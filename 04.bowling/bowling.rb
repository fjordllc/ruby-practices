#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

frames.each do |array|
  array.pop if array[0] == 10
end

index = []
frames.each_with_index do |s, f|
  index << [s, f]
end

sum_score = 0

(0..index.size - 1).each do |i|
  sum_score +=
    if index[i][1] + 1 >= 10
      index[i][0].sum
    elsif index[i][0][0] == 10
      if index[i + 1][0][0] == 10
        10 * 2 + index[i + 2][0][0]
      else
        10 + index[i + 1][0].sum
      end
    elsif index[i][0].sum == 10
      10 + index[i + 1][0][0]
    else
      index[i][0].sum
    end
end

p sum_score
