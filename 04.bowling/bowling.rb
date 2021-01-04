# !/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.chars
frames = []
frame = []

# 入力された数値に配列を指定する
scores.each do |s|
  # strike
  frame << (s == 'X' ? 10 : s.to_i)
  # 1投目で10本倒れたとき
  if frame.count == 1 && frame == [10]
    # framesにframeを代入
    frames << frame
    # 次のフレームを定義
    frame = []
  end
  # 2球投げたら
  next unless frame.count == 2

  # framesにframeを代入
  frames << frame
  # 次のフレームを定義
  frame = []
end

# 10フレームの合計が10なら最後のスコアを10フレーム目に代入する
if frames[9] != [10] && frames[9].sum == 10
  frames[9] << scores[-1].to_i
# 10フレーム目がストライクの場合
elsif frames[9] == [10] && frames.last == frames[11]
  frames[9].concat frames[10] + frames[11]
  frames.delete_at(10)
  frames.delete_at(10)
# 10フレーム目の1投目がストライク、2投3投目がストライクでもスペアでもない場合
elsif frames[9] == [10] && frames.last == frames[10]
  frames[9].concat frames[10]
  frames.delete_at(10)
end

# 1-8フレーム目までの計算
point1 = 0
frames[0..7].each_with_index do |frame, i|
  # 2回連続ストライクのときの計算
  point1 += if frame[0] == 10 && frames[i + 1][0] == 10
              20 + frames[i + 2][0]
            # ストライクのときの計算
            elsif frame[0] == 10
              10 + frames[i + 1][0] + frames[i + 1][1]
            # スペアの計算
            elsif frame.sum == 10
              10 + frames[i + 1][0]
            else
              frame.sum
            end
end

# 9フレーム目までの計算
point2 = if frames[8].sum == 10
           frames[8].sum + frames[9][0] + frames[9][1]
         else
           frames[8].sum
         end

# 10フレーム目の計算
point3 = frames[9].sum

puts point1 + point2 + point3
