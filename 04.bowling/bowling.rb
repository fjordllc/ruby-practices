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
  frames.each.with_index(1).sum do |points, number_of_frame|
    next_frame = frames[number_of_frame]
    after_next_frame = frames[number_of_frame + 1]

    if number_of_frame <= 9 && points[0] == 10 && frames[number_of_frame][0] == 10
      10 + next_frame[0] + after_next_frame[0]
    elsif number_of_frame <= 9 && points[0] == 10
      10 + next_frame.sum
    elsif number_of_frame <= 9 && points.sum == 10
      10 + next_frame[0]
    else
       points.sum
    end
  end

puts total
