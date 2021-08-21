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
  elsif shot[0] == 10 && frames.size != 9
    frames << [shot.shift]
  else
    frames << shot
  end
end

point = 0
frames.each_with_index do |frame, index|
  point = if index == 9
            point + frame.sum
          elsif frame[0] == 10
            point += if frames[index + 1][0] == 10 && index == 8
                       frames[index + 1][0] + frames[index + 1][1] + 10
                     elsif frames[index + 1][0] == 10
                       frames[index + 1][0] + frames[index + 2][0] + 10
                     else
                       frames[index + 1][0] + frames[index + 1][1] + 10
                     end
          elsif frame.sum == 10
            point + frames[index + 1][0] + 10
          else
            point + frame.sum
          end
end
puts point
