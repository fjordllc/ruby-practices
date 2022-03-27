#!/usr/bin/env ruby
# score = ARGV[0]
score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
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
shots.each_slice(2) do |s|
  frames << s
end
frames.each do |frame|
  if frame[0] == 10
    frame.pop #ストライクの場合は1フレーム一ム1投とする
  end
end

# 10フレーム目に３投目が存在する場合
if frames.size == 11
  frames << frames[-2].concat(frames.last)
  frames = frames.slice(0, 10)
end

score = 0
frames.each_with_index do |frame, i|
  if i < 9
    next_first_throw = frames[i + 1][0]
    if next_first_throw == 10
      next_second_throw = frames[i + 2][0]
    else
      next_second_throw = frames[i + 1][1]
    end
    #strikeの場合
    if frame[0] == 10
      score += 10 + next_first_throw + next_second_throw
      #spareの場合
    elsif frame.sum == 10
      score += 10 + next_first_throw
    else
      score += frame.sum
    end
  else
    #10投目
    score += frame.sum
  end
end
puts score
