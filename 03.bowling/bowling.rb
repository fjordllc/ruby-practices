#!/usr/bin/env ruby
# frozen_string_literal: true

def calculate_bowling_score(frames)
  total_score = 0
  frame_index = 0

  10.times do |_frame|
    if frames[frame_index] == 10
      total_score += 10 + frames[frame_index + 1] + frames[frame_index + 2]
      frame_index += 1
    elsif frames[frame_index] + frames[frame_index + 1] == 10
      total_score += 10 + frames[frame_index + 2]
      frame_index += 2
    else
      total_score += frames[frame_index] + frames[frame_index + 1]
      frame_index += 2
    end
  end

  total_score
end

shots = ARGV[0].split(',').map do |s|
  if s == 'X'
    10
  else
    s.to_i
  end
end
puts calculate_bowling_score(shots)
