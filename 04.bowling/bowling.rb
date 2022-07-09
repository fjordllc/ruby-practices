#!/usr/bin/env ruby

# frozen_string_literal: true

def calc_scores
  score = ARGV[0]
  scores = score.split(',').map { |shot| shot == 'X' ? 'X' : shot.to_i }
  puts calc_recursive(scores, 0, 0)
end

def calc_recursive(scores, index, frame_count)
  frame_count += 1
  if frame_count == 10
    last_frame = scores.pop(scores.size - index)
    return convert_x_to_i(last_frame).sum
  end

  shot = scores[index]
  sum_length = shot == 'X' || spare?(scores, index) ? 3 : 2
  shift_length = shot == 'X' ? 1 : 2
  next_index = index + shift_length
  sum_shots(scores, index, sum_length) + calc_recursive(scores, next_index, frame_count)
end

def spare?(scores, index)
  frame = scores.slice(index, 2)
  convert_x_to_i(frame).sum == 10
end

def sum_shots(scores, index, sum_length)
  shots = scores.slice(index, sum_length)
  convert_x_to_i(shots).sum
end

def convert_x_to_i(shots)
  shots.map { |shot| shot == 'X' ? 10 : shot }
end

calc_scores
