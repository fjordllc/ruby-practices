#!/usr/bin/env ruby
# frozen_string_literal: true

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

frames = shots.each_slice(2).to_a

point = (0..8).sum do |frame| # 1~8フレーム目までの計算
  next_frame = frame + 1
  next_to_next_frame = next_frame + 1

  if frames[frame][0] == 10 # strikeの場合
    if frames[next_frame][0] == 10 # 次フレームもstrikeの場合
      frames[next_to_next_frame][0] + 20
    else
      frames[next_frame].sum + 10
    end
  elsif frames[frame].sum == 10 # spare
    # spare特殊処理
    frames[next_frame][0] + 10
  else
    frames[frame].sum
  end
end

last_frame = frames[9].to_a + frames[10].to_a + frames[11].to_a
point += last_frame.sum # 最終フレームは便宜上、frames[9]~franes[11]と扱う

p point
