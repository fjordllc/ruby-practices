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

frames = shots.each_slice(2).to_a

frame10 = shots[18..].flatten.reject(&:zero?)
frames.slice!(9, 11)
frames << frame10

def double_strike?(next_frame, next_to_frame)
  next_frame && next_to_frame && next_frame[0] == 10
end

def calc_strike_point(next_frame, next_to_frame)
  if double_strike?(next_frame, next_to_frame)
    20 + (next_to_frame[0])
  else
    10 + (next_frame[0..1].sum)
  end
end

point = frames.each_with_index.sum do |frame, i|
  next_frame = frames[i + 1]
  next_to_frame = frames[i + 2]
  if i < 9
    if frame[0] == 10 # strike
      calc_strike_point(next_frame, next_to_frame)
    elsif frame.sum == 10 # spare
      10 + next_frame[0]
    else
      frame.sum
    end
  else
    frame.sum
  end
end

puts point
