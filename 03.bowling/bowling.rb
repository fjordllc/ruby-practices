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
shots.each_slice(2) do |shot|
  frames << shot
end

frame10 = shots[18..].flatten.reject(&:zero?)
frames.slice!(9, 11)
frames << frame10


def double_strike?(time, frames)
  next_frame = frames[time + 1]
  next_to_frame = frames[time + 2]
  next_frame && next_to_frame && next_frame[0] == 10
end

def calc_strike_point(time, frames)
  next_frame = frames[time + 1]
  next_to_frame = frames[time + 2]
  if time == 8 # 10フレーム目は3投することもあるため。
    10 + (next_frame[0] || 0) + (next_frame[1] || 0)
  elsif double_strike?(time, frames)
    20 + (next_to_frame[0] || 0)
  elsif next_frame
    10 + next_frame.sum
  end
end

point = frames.each_with_index.sum do |frame, i|
  if i < 9
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
