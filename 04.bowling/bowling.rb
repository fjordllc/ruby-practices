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
p shots

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  if frames[i][0] == 10
    p frames[i]
    point += 10 + frames[i + 1].sum
  elsif frame.sum == 10
    puts "#{frame}です。"
    #次の配列(frame)の一投目を加算
    point += 10 + frames[i + 1][0]
    p frames[i + 1]
  else
    point += frames[i].sum
    p frames[i]
  end
end
puts point

