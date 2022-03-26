#!/usr/bin/env ruby
# score = ARGV[0]
score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,３'
scores = score.split(',')

shots = []

scores.each do |s|
  if s == 'X' #strikeの場合一投目が10、二投目が0
    shots << 10
    shots << 0
  elsif shots << s.to_i
  end
end

frames = []
if shots.size == 20
  shots.each_slice(2) do |s|
    frames << s
  end
end
score = 0
frames.each do |frame|
  score += frame.sum
end
puts score
