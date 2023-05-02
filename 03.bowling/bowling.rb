#!/usr/bin/env ruby
# frozen_string_literal: true

def calculate_strike_additional_point(shots, shot_index)
  shots[shot_index + 1] + shots[shot_index + 2]
end

def calculate_spare_additional_point(shots, shot_index)
  shots[shot_index + 1]
end

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  shots <<  if s == 'X'
              10
            else
              s.to_i
            end
end

frame = []
point = 0

shots.each_with_index do |shot, shot_index|
  remaining_shot_number = shots.length - shot_index
  is_not_frame10 = (remaining_shot_number > 3)
  frame.push(shot)
  frame_sum = frame.sum
  next if frame.length == 1 && frame_sum < 10 && is_not_frame10
  point += frame_sum

  if frame[0] == 10 && is_not_frame10
    point += calculate_strike_additional_point(shots, shot_index)
  elsif frame_sum == 10 && is_not_frame10
    point += calculate_spare_additional_point(shots, shot_index)
  end
  frame.clear
end
puts point
