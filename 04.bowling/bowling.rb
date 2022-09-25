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

frame_with_number = {}
frames.each.with_index(1) { |fp, i| frame_with_number.store(i, fp) }

total = 
frame_with_number.each.sum do |number_of_frame, points|
    if number_of_frame <= 9 && points[0] == 10 && frame_with_number[number_of_frame + 1][0] == 10
      10 + frame_with_number[number_of_frame + 1][0] + frame_with_number[number_of_frame + 2][0]
    elsif number_of_frame <= 9 && points[0] == 10
      10 + frame_with_number[number_of_frame + 1].sum
    elsif number_of_frame <= 9 && points.sum == 10
      10 + frame_with_number[number_of_frame + 1][0]
    else
      points.sum
    end
end
puts total
