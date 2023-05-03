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
shots.each_slice(2) do |s|
  frames << s
end

while frames.include?(frames[10])
  frames[9].push(frames[10][0].to_i, frames[10][1].to_i)
  frames.pop
end

def sum_in_frame(frame)
  frame.sum
end

def calculate_spare(next_frame)
  10 + next_frame[0]
end

def calculate_strike(next_frame)
  10 + next_frame[0] + next_frame[1]
end

def calculate_double_strikes(frames, index, next_frame)
  if index == 8
    20 + next_frame[2]
  else
    20 + frames[index + 2][0]
  end
end

point = 0

frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  point += if index == 9
             sum_in_frame(frame)
           elsif frame[0] == 10
             if next_frame[0] == 10
               calculate_double_strikes(frames, index, next_frame)
             else
               calculate_strike(next_frame)
             end
           elsif frame.sum == 10
             calculate_spare(next_frame)
           else
             sum_in_frame(frame)
           end
end

puts point
