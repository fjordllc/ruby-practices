#!/usr/bin/env ruby
# frozen_string_literal: true

def calculate_spare_additional_point(shots, current_pitching)
  shots[current_pitching + 1]
end

def calculate_strike_additional_point(shots, current_pitching)
  shots[current_pitching + 1] + shots[current_pitching + 2]
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

shots.each_with_index do |value, current_pitching|
  remaining_pitching_number = shots.length - current_pitching
  is_not_frame10 = (remaining_pitching_number > 3)
  frame.push(value)
  if frame[0] == 10 && is_not_frame10
    point += frame[0] + calculate_strike_additional_point(shots, current_pitching)
    frame.clear
  elsif frame.sum == 10 && is_not_frame10
    point += frame.sum + calculate_spare_additional_point(shots, current_pitching)
    frame.clear
  elsif remaining_pitching_number == 1      # frame10のポイントの合計
    point += frame.sum
    frame.clear
  elsif frame.sum < 10 && frame.length == 2
    point += frame.sum
    frame.clear
  end
end
puts point
