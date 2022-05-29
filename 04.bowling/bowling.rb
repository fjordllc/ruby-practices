#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(",")
shots = []

scores.each do |s|
  if s == "X"
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
frames.each do |frame|
  p frame
  if frame[0] == 10 #strike
    #strike特殊処理
  elsif frame.sum == 10 #spare
    #spare特殊処理
    point 
  else
    point += frame.sum
  end
end

p point

