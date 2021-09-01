#!/usr/bin/env ruby
# frozen_string_literal: true

bowling_score = ARGV[0]
scores = bowling_score.split(',')
shots = []
scores.each do |score|
  if shots.size >= 18 && score == 'X'
    shots << 10
  elsif score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  if frames.size == 10
    frames[9] << shot[-1]
  else
    frames << shot
  end
end

point = frames.each_with_index.sum do |frame, index|
  if index == 9
    frame.sum
  elsif frame[0] == 10
    if frames[index + 1][0] == 10 && index == 8
      frames[index + 1][0] + frames[index + 1][1] + 10
    elsif frames[index + 1][0] == 10
      frames[index + 1][0] + frames[index + 2][0] + 10
    else
      frames[index + 1][0] + frames[index + 1][1] + 10
    end
  elsif frame.sum == 10
    frames[index + 1][0] + 10
  else
    frame.sum
  end
end

puts point
