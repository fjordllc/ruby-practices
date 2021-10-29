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
frame_count = 1
MAX_FRAME_COUNT = 10

while frame_count <= MAX_FRAME_COUNT
  if frame_count == MAX_FRAME_COUNT
    frames << score.slice((frame_count - 1) * 2..-1)
    break
  else
    frames << score.slice((frame_count - 1) * 2, 2)
    frame_count += 1
  end
end

total_points = 0
frames.each_with_index do |frame, index|
  total_points += frame.sum
  # 最終フレームの場合
  break if index == frames.size - 1

  # ストライクの場合
  if frame[0] == 10
    total_points += frames[index + 1][0]
    total_points +=
      # 最初の投球の次の投球もストライクの場合
      if frames[index + 1][0] == 10
        index + 1 == frames.size - 1 ? frames[index + 1][2] : frames[index + 2][0]
      else
        frames[index + 1][1]
      end
  # スペアの場合
  elsif frame[0] != 10 && frame.sum == 10
    total_points += frames[index + 1][0]
  end
end

p total_points
