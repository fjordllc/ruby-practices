# frozen_string_literal: true

base = ARGV[0].split(',')
score = []
base.each do |value|
  if value == 'X'
    score << 10
    score << 0
  else
    score << value.to_i
  end
end

frames = []
MAX_FRAME_COUNT = 10

while frames.count < (MAX_FRAME_COUNT - 1)
  # 9フレーム目までの処理
  frames << score.slice(frames.count * 2, 2)
end
# 10フレーム目までの処理
frames << score.slice(frames.count * 2..-1)

total_points = 0
frames.each.with_index(1) do |frame, index|
  total_points += frame.sum

  break if index == frames.size

  if frame[0] == 10
    total_points += frames[index][0]
    total_points +=
      # 最初の投球の次の投球もストライクの場合
      if frames[index][0] == 10
        index == frames.size - 1 ? frames[index][2] : frames[index + 1][0]
      else
        frames[index][1]
      end

  # スペアの場合
  elsif frame.sum == 10
    total_points += frames[index][0]

  end
end

p total_points
