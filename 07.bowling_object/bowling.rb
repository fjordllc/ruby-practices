# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'x' # xはストライク
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  if s.sum >= 11
    p '倒しているピンの数が不正です'
    exit
  end

  frames << s
end

unless frames.count == 10 || frames.count == 11
  p 'フレーム数が不正です'
  exit
end

point = frames[0..8].each_with_index.sum do |frame, idx|
  if frame[0] == 10 && frames[idx + 1][0] == 10
    10 + frames[idx + 1].sum + frames[idx + 2][0]
  elsif frame[0] == 10
    10 + frames[idx + 1].sum
  elsif frame.sum == 10
    10 + frames[idx + 1][0]
  else
    frame.sum
  end
end

if frames[10] && frames[10].count == 1
  point += frames[9].sum + frames[10].sum
elsif frames[10].nil?
  point += frames[9].sum
else
  p '10フレーム目が不正です'
  exit
end

p point
