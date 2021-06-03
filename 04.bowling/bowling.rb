#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  elsif s == 'S'
    shots << 10
  else
    shots << s.to_i
  end
end
each_shot_score_sum = shots.sum

frames = []
shots.each_slice(2) do |s|
  frames << s
end

#加算について
add_point = 0

frames[0..7].each_with_index do |frame, n|
  if frames[n].sum == 10 && frames[n][0] != 10
    add_point += frames[n + 1][0]
  elsif frames[n][0] == 10 && frames[n + 1][0] == 10
    add_point += frames[n + 1][0] + frames[n + 2][0]
  elsif frames[n][0] == 10
    add_point += frames[n + 1].sum
  else
    add_point += 0
  end
end

add_point_9 = 0

if frames[8].sum == 10 && frames[8][0] != 10
  add_point_9 += frames[9][0]
elsif frames[8][0] == 10 && frames[9][0] == 10
  add_point_9 += frames[9][0] + frames[10][0]
elsif frames[8][0] == 10 && frames[9][0] != 10
  add_point_9 += frames[9].sum
else
  add_point_9 += 0
end

puts each_shot_score_sum + add_point + add_point_9

