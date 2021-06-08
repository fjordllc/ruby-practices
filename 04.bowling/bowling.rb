#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',').map do |s|
  s == 'X' ? 10 : s.to_i
end

# フレーム数は10固定のため10回ループさせて10個の配列を作成する
frames = (1..10).map do |time|
  # フレーム10の場合は残った要素全てを10個目の配列に入れる
  if time == 10
    scores
  # ストライクの場合はXのみを配列に入れて次のループに進む
  elsif scores.first == 10
    scores.shift(1)
  # 上記以外の場合は２つずつ配列に入れて次のループに進む
  else
    scores.shift(2)
  end
end

points = []
frames.each_with_index do |frame, i|
  point = frame.sum
  # ストライクの場合
  if frame[0] == 10 && i < 9
    point += frames[i + 1][0, 2].sum
    # ストライクが続いた場合の処理(ネストが深いので要修正だと思う)
    if frames[i + 1][0] == 10 && i < 8
      point += frames[i + 2][0]
    end
  # スペアの場合
  elsif point == 10 && i < 9
    point += frames[i+ 1][0]
  end
  points << point
end

puts points.sum
