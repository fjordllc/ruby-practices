#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')

shots = scores.map do |s|
  s == 'X' ? [10, 0] : s.to_i
end.flatten

frames = shots.each_slice(2).to_a

point = frames.each_with_index.sum do |f, i|
  if i <= 8
    if f[0] == 10
      frames[i + 1][0] == 10 ? 10 + 10 + frames[i + 2][0] : 10 + frames[i + 1].sum
    elsif f.sum == 10
      10 + frames[i + 1][0]
    else
      f.sum
    end
  else
    f.sum
  end
end

puts point
