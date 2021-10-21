#!/usr/bin/env ruby
# frozen_string_literal: true

# 引数をとって、1投ごとに分割
score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# フレームごとに分割
frames = []
shots.each_slice(2) do |s|
  if s == [10, 0]
    frames << [s.shift]
    next
  else
    frames << s
  end
end

# 10フレーム目が3投ある場合、全て連結する
if frames[9].sum == 10
  frames[9] += frames[10] if frames[10]
  frames[9] += frames[11] if frames[11]
  frames.slice!(10, frames.size)
end

# スコアを計算
point = 0
frames.each_with_index do |frame, index|
  if index <= 8 # 9フレーム目までの計算
    strike = frame.size == 1 && frame[0] == 10
    spare = frame.size == 2 && frame.sum == 10
    next_score_first = frames[index + 1][0]
    next_score_second = frames[index + 1][1]

    point += if strike
               10 + next_score_first + next_score_second
             elsif spare
               10 + next_score_first
             else
               frame.sum
             end
  elsif index == 9 # 10フレーム目の計算
    point += frame.sum
    p "#{index + 1}投目: #{frame} #{point}点"
    break
  end

  p "#{index + 1}投目: #{frame} #{point}点"
end
puts point
