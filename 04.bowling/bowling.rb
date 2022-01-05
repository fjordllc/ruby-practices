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

point = 0
frames.each_with_index do |f, i|
  point += if i <= 8
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
