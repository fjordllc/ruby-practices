#!/usr/bin/env ruby
# frozen_string_literal: true

pins = ARGV[0].chars
shots = []
pins.each do |pin|
  if pin == 'X'
    shots << 10
    shots << 0
  else
    shots << pin.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

frame_score = []
frames.each_with_index do |frame, n|
  if frame[0] == 10 && n < 9
    if (frames[n + 1])[0] == 10 && (frames[n + 2])[0] == 10
      frame_score << 30
    elsif n < 8 && (frames[n + 1])[0] == 10
      frame_score << 20 + (frames[n + 2])[0]
    else
      frame_score << 10 + frames[n + 1].sum
    end
  elsif frame.sum == 10 && n < 9
    frame_score << 10 + (frames[n + 1])[0]
  else
    frame_score << frame.sum
  end
end

puts frame_score.sum
