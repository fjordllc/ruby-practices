#!/usr/bin/env ruby
score = ARGV[0]
scores = score.chars
shots = []
scores.each do |s|
  if s == 'X' # strike
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

p frames

point = 0
#フレーム数を表すインデックス変数
frames_index = 0

frames.each do |frame|
  p (frames_index + 1).to_s + "フレーム目"
  if frames_index >= 9
      # 10フレーム目のみは単純に加算する
      p "10フレーム目だよ"
      point += frame.sum
  elsif frame.sum == 10 && frame[0] != 10
      # スペアの場合
      # 次フレームの1投目の得点を追加で加算
      p "スペア"
      point +=frame.sum + frames[frames_index + 1][0]
  elsif frame[0] == 10
      # ストライクの場合
      # 次のフレームの1,2投目の合計を追加で加算
      p "ストライク"
      point +=frame.sum + frames[frames_index + 1][0] + frames[frames_index + 1][1];
  else
      #スペアでもストライクでもない場合は、単純に1フレームの合計値を加算
      p "スペアでもストライクでもなし"
      point += frame.sum
  end
  p (frames_index + 1).to_s + "フレーム目の得点"
  p point
  # フレームを1つ進める
  frames_index += 1
end

p "総合得点"
p point
