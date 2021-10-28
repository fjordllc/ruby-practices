#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << if s == [10, 0]
              [s.shift]
            else
              s
            end
end

if frames[9].sum == 10
  frame_last = frames.slice!(9..).flatten
  frames << frame_last
end

point = 0
frames.each_with_index do |frame, index|
  if index <= 8
    strike = frame[0] == 10
    spare = frame.size >= 2 && frame.sum >= 10
    next_score_first = frames[index + 1][0]
    next_score_second = frames[index + 1][1] || frames[index + 2][0]

    point += if strike
               10 + next_score_first + next_score_second
             elsif spare
               10 + next_score_first
             else
               frame.sum
             end
  else
    point += frame.sum
  end
end
puts point
