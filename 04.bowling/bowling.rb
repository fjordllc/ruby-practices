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

<<<<<<< HEAD
frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0

(0..7).each do |frame| # 1~8フレーム目までの計算
  next_frame = frame + 1
  next_to_next_frame = next_frame + 1

  point += if frames[frame][0] == 10 # strikeの場合
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

point += if frames[8][0] == 10 # 9フレーム目の計算,strike
           if frames[9][0] == 10 # 10フレーム目の1投目がstrike
             frames[10][0] + 20
           else
             frames[9].sum + 10
           end
         elsif frames[8].sum == 10 # 9フレーム目の計算,spare
           frames[9][0] + 10
         else
           frames[8].sum
         end

=======
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

>>>>>>> c3975f33e6c813800d4b91bbe01a6254bc6c4108
last_frame = frames[9].to_a + frames[10].to_a + frames[11].to_a
point += last_frame.sum # 最終フレームは便宜上、frames[9]~franes[11]と扱う

p point
