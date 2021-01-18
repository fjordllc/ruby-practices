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
one_frame = []
shots.each_with_index do |shot, n|
  if frames.size < 9
    one_frame << shot
    if one_frame.size == 2
      frames << one_frame
      one_frame = []
    end
  else
    one_frame << shot unless shots[n - 1] == 10
    frames << one_frame if n == shots.size - 1
  end
end

total_score = frames.each_with_index.sum do |frame, n|
  if n < 8 && frame[0] == 10
    if (frames[n + 1])[0] == 10 && (frames[n + 2])[0] == 10
      30
    elsif (frames[n + 1])[0] == 10
      20 + (frames[n + 2])[0]
    else
      10 + (frames[n + 1]).sum
    end
  elsif n == 8 && frame[0] == 10
    if frames[9][0] == 10
      if frames[9][1] == 10
        30
      else
        20 + (frames[9])[1]
      end
    else
      10 + (frames[9])[0] + (frames[9])[1]
    end
  elsif n < 8 && frame.sum == 10
    10 + (frames[n + 1])[0]
  else
    frame.sum
  end
end

puts total_score
