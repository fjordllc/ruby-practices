# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

strike = 10

scores.each do |s|
  if s == 'X'
    shots << strike
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
total_score = 0
frames.each_with_index do |frame, index|
  if index < 9 # 10フレーム目以外の処理
    # ストライクのとき
    if frame == [10, 0] && frames[index + 1] == [10, 0]
      frame << frames[index + 1].first + frames[index + 2].first
    elsif frame == [10, 0] && frames[index + 1] != [10, 0]
      frame << frames[index + 1].sum
    end
    # スペアのとき
    frame << frames[index + 1].first if frame.sum == 10
  end
  total_score += frame.flatten.sum
end

puts total_score
