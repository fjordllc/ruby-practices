#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |strike|
  if strike == 'X'
    shots << 10
    shots << 0
  else
    shots << strike.to_i
  end
end
frames = []
shots.each_slice(2) do |frame|
  frames << frame
end

points = 0
frames.each_with_index do |point, i|
  if point == [10, 0] && i < 10
    points +=
      if frames[i + 1] != [10, 0]
        point.sum + frames[i + 1].sum
      else
        point.sum + frames[i + 1].sum + frames[i + 2][0]
      end
  elsif point.sum == 10 && i < 10
    points += point.sum + frames[i + 1][0]
  elsif i < 10
    points += point.sum
  end
end
puts points
