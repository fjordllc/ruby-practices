#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
count = 0
scores.each do |s|
  count += 1
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

points = []
frames.each_with_index do |frame, i|
  points[i] = frame.sum
  if i < 9
    if frame[0] == 10
      points[i] += frames[i + 1][0]
      points[i] += if frames[i + 1][0] == 10
                     frames[i + 2][0]
                   else
                     frames[i + 1][1]
                   end
    elsif frame.sum == 10
      points[i] += frames[i + 1][0]
    end
  end
end
puts points.sum
