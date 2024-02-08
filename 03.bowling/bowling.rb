#!/usr/bin/env ruby
# frozen_string_literal: true

def calculate_bowling_score(shots)
  total_score = 0
  shot_index = 0

  10.times do
    if shots[shot_index] == 10
      total_score += 10 + shots[shot_index + 1] + shots[shot_index + 2]
      shot_index += 1
    elsif shots[shot_index] + shots[shot_index + 1] == 10
      total_score += 10 + shots[shot_index + 2]
      shot_index += 2
    else
      total_score += shots[shot_index] + shots[shot_index + 1]
      shot_index += 2
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
