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
  point += if index <= 8 && frame.length == 2 && frame.sum == 10 # スペア
             10 + frames.dig(index + 1, 0)
           elsif index <= 8 && frame[0] == 10 # ストライク
             if frames[index + 1].length == 2 # 次投がストライク以外
               10 + frames[index + 1].sum
             else
               10 + 10 + frames.dig(index + 2, 0) # 次投がストライク
             end
           else
             frame.sum
           end
end

puts point
