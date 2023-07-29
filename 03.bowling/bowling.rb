# frozen_string_literal: true
require 'debug'
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
shots.each_slice(2) do |shot|
  frames << shot
end

frame_10 = shots[18..].flatten.reject { |n| n.zero? }
frames.slice!(9, 11)
frames << frame_10

def calc_strike_point(time, frames)
  next_frame = frames[time + 1]
  next_to_frame = frames[time + 2]
  if time == 8 && next_frame
    10 + next_frame[0] + next_frame[1]
  elsif next_frame && next_to_frame && next_frame[0] == 10
    20 + next_to_frame[0]
  elsif next_frame
    10 + next_frame[0]
  end
end

point = 0
frames.each_with_index do |frame, i|
  point += if i < 9
             if frame[0] == 10 # strike
               calc_strike_point(i, frames)
             elsif frame.sum == 10 # spare
               10 + frames[(i + 1)][0]
             else
               frame.sum
             end
             elsif i == 9
             frame.sum
           end
end
puts point
