#!/usr/bin/env ruby
# frozen_string_literal: true

pins = ARGV[0].chars
shots = []
pins.each_with_index do |pin, n|
  if pin == 'X'
    shots << 10
    shots << 0 unless pins[n - 1] == '0' && shots.size.even?
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
  frame_score <<
    if frame[0] == 10 && n < 9
      if (frames[n + 1])[0] == 10 && (frames[n + 2])[0] == 10
        30
      elsif n < 8 && (frames[n + 1])[0] == 10
        20 + (frames[n + 2])[0]
      else
        10 + frames[n + 1].sum
      end
    elsif frame.sum == 10 && n < 9
      10 + (frames[n + 1])[0]
    else
      frame.sum
    end
end

puts frame_score.sum
