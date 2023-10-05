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

# スコアを加算
total_score = 0
10.times do |i|
  total_score += frames[i].sum
  # カレントフレームでstrike
  if frames[i][0] == 10
    total_score += frames[i + 1].sum
    # 次のフレームもstrikeだった場合、更に次のフレームの１投目も加算
    total_score += frames[i + 2][0] if frames[i + 1][0] == 10
  # カレントフレームでspare
  elsif frames[i].sum == 10
    total_score += frames[i + 1][0]
  end
end

puts total_score
