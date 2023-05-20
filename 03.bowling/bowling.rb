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
# ここまで新ルールと同様

# 配列shotsを2つずつに分割した配列sをつくる
# 配列framesに、キーを:score,値を配列sとしたハッシュを追加していく
# 第10フレームでストライクかスコアがあると、framesの要素数が11もしくは12になる
frames = []
shots.each_slice(2) do |s|
  frames << { score: s }
end

# framesの各要素の:scoreの値から:sumと:markの値を決定してハッシュに追加
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
    frame[:mark] = :none
  end
end

# 1フレームから9フレームにおいて、ストライクとスペアのフレームの:sumを再計算
# ストライクで、かつ次のフレームもストライクであれば「10 + 2つ次のフレームの1投目」を加算
# ストライクで、次のフレームがストライクでなければ、次のフレームの合計値を加算
# スペアであれば、次のフレームの1投目を加算
9.times do |n|
  current = frames[n]
  one_ahead = frames[n + 1]
  two_ahead = frames[n + 2]
  if current[:mark] == :strike
    current[:sum] +=
      if one_ahead[:mark] == :strike
        10 + two_ahead[:score][0]
      else
        one_ahead[:score].sum
      end
  elsif current[:mark] == :spare
    current[:sum] += one_ahead[:score][0]
  end
end
# 10フレーム目の得点はframesの10番目以降の要素の:sumの合計と等しくなるので再計算は不要

# framesの全ての要素の:sumを合計してpointとする
point = 0
frames.each do |frame|
  point += frame[:sum]
end

puts point
