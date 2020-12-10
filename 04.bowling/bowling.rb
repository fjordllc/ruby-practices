# frozen_string_literal: true

# !/usr/bin/env ruby

score = ARGV[0]
score_chars = score.chars
scores = []
frame = []

score_chars.each do |s|
  frame << (s == 'X' ? 10 : s.to_i)
  if frame.count == 1 && frame.first == 10
    scores << frame
    frame = []
  end
  if frame.count == 2
    scores << frame
    frame = []
  end
end

scores[9] << score_chars.last.to_i if scores[9] != [10] && scores[9].sum == 10

normal_frame = scores.take(9)
last_frame = scores[9..].flatten(1)
scores = normal_frame << last_frame

frame_scores = []

10.times do |i|
  next_frame = i + 1
  next_next_frame = i + 2
  total_score =
      if i > 8
        scores[i].sum
      elsif scores[i].count == 1 && scores[next_frame].count == 1
        20 + scores[next_next_frame].first
      elsif scores[i].count == 1 && scores[next_frame].count == 2
        10 + scores[next_frame].sum
      elsif scores[i].count == 1 && scores[next_frame].count == 3
        10 + scores[next_frame][0] + scores[next_frame][1]
      elsif scores[i].count == 2 && scores[i].sum == 10 && scores[next_frame].count == 3
        10 + scores[next_frame][0]
      elsif scores[i].count == 2 && scores[i].sum == 10
        10 + scores[next_frame].first
      else
        scores[i].sum
      end
  frame_scores << total_score
end

p frame_scores.sum
