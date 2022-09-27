#!/usr/bin/env ruby
# frozen_string_literal: true

scores = []
ARGV[0].split(',').each do |n|
  if n == 'X'
    scores << 10
    scores << 0
  else
    scores << n.to_i
  end
end

frames = scores.each_slice(2).to_a

total =
  frames.each.with_index(1).sum do |points, frame_number|
    next_points = frames[frame_number]
    after_next_points = frames[frame_number + 1]
    not_last_frame = frame_number <= 9
    strike = not_last_frame && points[0] == 10
    double = strike && frames[frame_number][0] == 10
    spare = not_last_frame && points.sum == 10

    if double
      10 + next_points[0] + after_next_points[0]
    elsif strike
      10 + next_points.sum
    elsif spare
      10 + next_points[0]
    else
      points.sum
    end
  end

puts total
