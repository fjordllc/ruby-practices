#!ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

# 受け取った引数からショット毎のスコアを計算 & ストライクの時に10, 0を追加し、各フレーム毎に２要素または３要素あるように調整する。
scores.each do |s|
  if shots.length >= 18 # １０フレーム目の処理
    shots << if s == 'X' # strike
               10
             else
               s.to_i
             end
  elsif s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# フレーム毎のショットのスコアをarrayとして含むframesを定義
frames = [] * 10
shot_index = 0

while shot_index < shots.length
  if shot_index > 18
    frames[9] << shots[shot_index]
    shot_index += 1
  else
    frames << [shots[shot_index], shots[shot_index + 1]]
    shot_index += 2
  end
end

# ショットのスコアから各フレーム毎にゲームスコアを計算し、pointに合計スコアをまとめる。
point = 0
frames.each.with_index(1) do |frame, index|
  i = index - 1
  point +=
    # １０フレーム目の時
    if i == 9
      frame.sum
    # Strike case
    elsif frame[0] == 10
      # next frame is not strike or frame[8][0] == 10
      if i == 8 || frames[i + 1][0] != 10
        10 + frames[i + 1][0] + frames[i + 1][1]
      # next frame is also strike
      else
        10 + 10 + frames[i + 2][0]
      end
    # Spare case
    elsif frame.sum == 10
      frame.sum + frames[i + 1][0]
    # Normal case
    else
      frame.sum
    end
end
puts point
