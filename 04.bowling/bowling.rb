#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) { |s| frames << s }
points = 0

frames.each_with_index do |frame, index|
  if index == 9 && frame[0] == 10
    points += if frames[11]
                10 + frames[10].sum + frames[11].sum
              else
                10 + frames[10].sum
              end
  elsif index == 9 && frame[0] != 10 && frame.sum == 10
    points += 10 + frames[10].sum
  elsif index == 9 && frame.sum != 10
    points += frame.sum
  elsif index == frames.size - 2 && frames.size - 2 < 9
    points += frame.sum
  elsif index == frames.size - 1 || index == frames.size - 2
    next
  elsif frame[0] == 10 && frames[index + 1][0] != 10
    points += 10 + frames[index + 1].sum
  elsif frame[0] == 10 && frames[index + 1][0] == 10
    points += 10 + frames[index + 1][0] + frames[index + 2][0]
  elsif frame[0] != 10 && frame.sum == 10
    points += 10 + frames[index + 1][0]
  else
    points += frame.sum
  end
end
puts points
