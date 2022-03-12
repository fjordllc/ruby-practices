# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if (shots.size >= 18) && (s == 'X') # 10フレーム目の3投目処理
    shots << 10
  elsif s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# 最終フレームで３投目があった場合
third_shot = shots.pop if shots.size == 21

frames = []
shots.each_slice(2) do |s|
  # frameからstrikeの時の0を削除 ※10投目以外
  s.pop  if (s[0] == 10) && (frames.size <= 8)
  frames << s
end

# 最終フレームの3投目を追加
frames.last.push(third_shot) if frames.last.sum >= 10

point = 0
frames.each_with_index do |frame, i|
  next_frame = frames[i + 1] unless i == 9
  point += if frame.size == 3 # 10フレームで3投した場合
             frame.sum
           elsif (frame.size == 1) && (next_frame.size == 1) # 連続strike
             10 + next_frame.sum + frames[i + 2][0]
           elsif frame.size == 1 # strike
             10 + next_frame[0] + next_frame[1]
           elsif frame.sum == 10 # spare
             10 + next_frame[0]
           else
             frame.sum
           end
end
puts point
