#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |shot|
  if shot == 'X'
    shots << 10
    shots << 0 # ストライク時の２投目を仮登録
  else
    shots << shot.to_i
  end
end

frames = []
frames = shots.each_slice(2).to_a

frames.each do |frame|
  frame.pop if frame[0] == 10 # 仮登録したストライク時の２投目を削除
end

point = 0
frames.each_with_index do |frame, index|
  point += frame.sum
  next if index > 8 || frame.sum != 10

  point += if frame.length == 2 # スペア
             frames.dig(index + 1, 0)
           elsif frames[index + 1].length == 2 # ストライクで次投がストライク以外
             frames[index + 1].sum
           else
             10 + frames.dig(index + 2, 0) # ストライクで次投がストライク
           end
end

puts point
