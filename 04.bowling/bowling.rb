#!/usr/bin/env ruby

score = ARGV[0]

score_strings = score.split(',')

scores = []
score_strings.each do |n|
  if n == 'X'
    scores << 10
    scores << 0
  else
    scores << n.to_i
  end
end

frames = []
scores.each_slice(2) do |f|
  frames << f
end

frame_with_number = Hash.new; frames.each.with_index(1){|fp, i|frame_with_number.store(i, fp)}

total = 0
frame_with_number.each do |frame, point|
  case
  when frame <= 9 && point[0] == 10 && frame_with_number[frame+1][0] == 10# strike
    total += 10 + frame_with_number[frame+1][0] + frame_with_number[frame+2][0] 
  when frame <= 9 && point[0] == 10
    total += 10 + frame_with_number[frame+1].sum
  when frame <= 9 && point.sum == 10
    total += 10 + frame_with_number[frame+1][0]
  else
    total += point.sum
  end
end
puts total
