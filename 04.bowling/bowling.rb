# !/usr/bin/env ruby
# fronze_string_literal: true
score = ARGV[0]
scores = score.chars
frames = []
frame = []

scores.each do |s|
  frame << 10 if s == 'X'
  frame << s.to_i if s != 'X'
  if frame.count == 1 && frame.first == 10
    frames << frame
    frame = []
  end
  if frame.count == 2
    frames << frame
    frame = []
  end
end

frames[9] << scores.last.to_i if frames[9] != [10] && frames[9].sum == 10

normal_frame = frames.take(9)
last_frame = frames[9..].flatten(1)
frames = normal_frame << last_frame

frame_score = []
total_score = []

10.times do |i|
  next_frame = i + 1
  next_next_frame = i + 2
  if i < 9
    if frames[i].count == 1 && frames[next_frame].count == 1
      total_score = 20 + frames[next_next_frame].first
    elsif frames[i].count == 1 && frames[next_frame].count == 2
      total_score = 10 + frames[next_frame].sum
    elsif frames[i].count == 1 && frames[next_frame].count == 3
      total_score = 10 + frames[next_frame][0] + frames[next_frame][1]
    elsif frames[i].count == 2 && frames[i].sum == 10 && frames[next_frame].count == 3
      total_score = 10 + frames[next_frame][0]
    elsif frames[i].count == 2 && frames[i].sum == 10
      total_score = 10 + frames[next_frame].first
    else
      total_score = frames[i].sum
    end
  else
    total_score = frames[i].sum
  end
  frame_score << total_score
end

p frame_score.sum
