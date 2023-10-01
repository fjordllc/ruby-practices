#! /usr/bin/env ruby

# １投ごとに分割する
score = ARGV[0]
scores = score.split(',')

# スコアを数値に変換
shots = []
scores.each do |s|
    if s == 'X'
        shots << 10
        shots << 0
    else
        shots << s.to_i
    end
end

# フレームごとに分割
frames = []
shots.each_slice(2) do |s|
    frames << s
end

# ポイントを加算
point = 0
frames.each do |frame|
    if frame[0] == 10 #strike
        point += 30
    elsif frame.sum == 10 #spare
        point += frame[0] + 10
    else
        point += frame.sum
    end
end
puts point
