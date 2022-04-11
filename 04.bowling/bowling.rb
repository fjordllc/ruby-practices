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

point = frames.first(10).each_with_index.sum do |frame, i|
  next_frame = frames[i + 1]
  afternext_frame = frames[i + 2]

  if frame[0] == 10 # strike
    score = 0
    score += afternext_frame[0] if next_frame[0] == 10
    score + 10 + next_frame.sum

  elsif frame.sum == 10 # spare
    10 + next_frame[0]

  else
    frame.sum
  end
end

puts point
