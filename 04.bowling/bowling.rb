#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]

score_strings = score.split(',')

scores = []
score_strings.each do |n|
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
    double = frame_number <= 9 && points[0] == 10 && frames[frame_number][0] == 10
    strike = frame_number <= 9 && points[0] == 10
    spare = frame_number <= 9 && points.sum == 10

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
