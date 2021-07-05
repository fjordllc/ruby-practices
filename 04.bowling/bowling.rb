#!/usr/bin/env ruby
# frozen_string_literal: true

# 数値に変換
scores = ARGV[0].split(',').map do |score|
  score == 'X' ? 10 : score.to_i
end

frame = []
frames = []
scores.each_with_index do |score, i|
  frame << score

  # フレームの区切りを判定
  if frames.size + 1 <= 9 # 9フレーム目まで
    if (frame.size == 1 && score == 10) || frame.size == 2 # ストライクもしくは2投目
      frames << frame.dup
      frame.clear
    end
  elsif i == scores.size - 1 # 最後の投球
    frames << frame.dup
    frame.clear
  end
end

point = 0
frames.each_with_index do |current_frame, i|
  point += current_frame.sum

  # ストライク・スペアによるポイントの加算
  if i + 1 <= 9 # 9フレーム目まで
    if current_frame[0] == 10 # strike
      point += frames[i + 1][0]
      point += frames[i + 1].size == 1 ? frames[i + 2][0] : frames[i + 1][1]
    elsif current_frame.sum == 10 # spare
      point += frames[i + 1][0]
    end
  end
end

puts point
