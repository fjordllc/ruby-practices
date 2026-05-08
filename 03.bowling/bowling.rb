#!/usr/bin/env ruby
# frozen_string_literal: true

input = ARGV[0]
shots = input.split(',').map { |s| s == 'X' ? 10 : s.to_i }

scores = []
9.times do
  shot1 = shots.shift
  frame_score = if shot1 == 10
                  10 + shots[0] + shots[1]
                else
                  shot2 = shots.shift
                  frame_total = shot1 + shot2
                  if frame_total == 10
                    10 + shots[0]
                  else
                    frame_total
                  end
                end
  scores << frame_score
end
scores << shots.sum
puts scores.sum
