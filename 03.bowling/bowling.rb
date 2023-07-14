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

point = 0

frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  next_after_frame = frames[index + 2]

  point += if frame[0] == 10 && next_frame[0] == 10 # strike
             10 + next_frame[0] + next_after_frame[0]
           elsif frame[0] == 10 && next_frame[0] != 10 # strike
             10 + next_frame.sum
           elsif frame.sum == 10 # spare
             10 + next_frame[0]
           else
             frame.sum
           end

  break if index == 9
end
puts point
