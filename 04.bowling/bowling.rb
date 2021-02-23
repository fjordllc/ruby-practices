#!/usr/bin/env ruby

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
shots.each_slice(2){|s| frames << s}
p frames
points = 0

frames.each_with_index do |frame, index|
  if index == 9 && frame[0] == 10
    points += 10 + frames[10].sum + frames[11].sum
  elsif index == 9 && frame[0] != 10 && frame.sum == 10
    points += 10 + frames[10].sum
  elsif index == 9 && frame.sum != 10
    points += frame.sum
  elsif index == frames.size - 2 && frames.size - 2 < 9
    points += frame.sum
  elsif index == frames.size - 1 || index == frames.size - 2
    next
  elsif frame[0] == 10 && frames[index + 1][0] != 10
    points += 10 + frames[index + 1].sum
  elsif frame[0] == 10 && frames[index + 1][0] == 10
    points += 10 + frames[index + 1][0] + frames[index + 2][0]
  elsif frame[0] != 10 && frame.sum == 10
    points += 10 + frames[index + 1][0]
  else
    points += frame.sum
  end
end
p points

#frames.each_with_index do |frame, index|
#  if frame[0] == 10 && index != 9
#    points += 10 + frames[index + 1].sum
#  elsif frame[0] != 10 && frame.sum == 10 && index != 9
#    points += 10 + frames[index + 1][0]
#  elsif frame[0] == 10 && index == 9 || frame.sum == 10 && index == 9
#    points += frame.sum + frames[index + 1].sum
#  elsif index >= 10
#    next
#  else
#    points += frame.sum
#  end
#end
#p points


#scores.each_with_index do |n, index|
#  if n == "X" && scores[index-1] > 0
#    shots << 10
#    shots << 0
#  elsif n == "X" && scores[index-1] == 0
#    shots << 0
#    shots << 10
#  else
#    shots << n.to_i
#  end
#end
#p shots

#frames = []
#frame = []
#shots.each_with_index do |n, index|
#  #ストライク
#  if n == 10 && index.even?
#    frame << n
#    frames << frame
#  elsif n == 10 && index.odd?

#frames = []
#shots.each_slice(1) do |n|
#  frames << n
#end
#p frames

#一番最初からペアにしていって、最初に出会ったXが偶数インデックスならストライク。奇数インデックスならスペア

#前のフレームのインデックス1が隣にある or 前のフレームがXであるXはストライク。インデックス1のXはスペア




#p scores
#scores.each do |n|
#  if n == 'X'
#    shots << 10
#    shots << 0 
#  else
#    shots << n.to_i
#  end
#end
#
#frames = shots.each_slice(2).to_a
#p frames
#summed_frames = []
#frames.each_with_index do |frame, index|
#  if frame.sum == 10 && frame[1] == 0
#    p frame
#    summed_frames << frame.sum + frames[index + 1].sum
#  elsif frame.sum == 10 && frame[1] != 0
#    p frame
#    summed_frames << frame.sum + frames[index + 1][0]
#  else
#    p frame
#    summed_frames << frame.sum
#  end
#end
#
#if summed_frames.size > 10
#  summed_frames.delete_at(10)
#end
#
#p summed_frames.sum

