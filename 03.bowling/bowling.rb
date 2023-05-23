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

# 第10フレームでストライクかスコアがあると、framesの要素数が11もしくは12になる
frames = []
shots.each_slice(2) do |s|
  frames << { score: s }
end

# ストライクかスペアの際は:sumを暫定的に10とする
frames.each do |frame|
  if frame[:score][0] == 10
    frame[:sum] = 10
    frame[:mark] = :strike
  elsif frame[:score].sum == 10
    frame[:sum] = 10
    frame[:mark] = :spare
  else
    frame[:sum] = frame[:score].sum
  end
end

# 1フレームから9フレームにおいて、ストライクとスペアのフレームの:sumを再計算
# 10フレーム目の得点はframesの10番目以降の要素の:sumの合計と等しくなるので再計算は不要
9.times do |n|
  current_frame = frames[n]
  one_ahead_frame = frames[n + 1]
  two_ahead_frame = frames[n + 2]
  if current_frame[:mark] == :strike
    current_frame[:sum] +=
      if one_ahead_frame[:mark] == :strike
        10 + two_ahead_frame[:score][0]
      else
        one_ahead_frame[:score].sum
      end
  elsif current_frame[:mark] == :spare
    current_frame[:sum] += one_ahead_frame[:score][0]
  end
end

point = 0
frames.each do |frame|
  point += frame[:sum]
end

puts point
