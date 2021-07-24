# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

# Xのときは2,その他のときは1としてカウントしたときに合計が18になるところが9フレーム目、20 or 21が最終フレームになる
# 最終フレームはXがあっても0を入れずにそのまま10で置き換える
shots = []
num_count = 0
scores.each do |s|
  if num_count == 18
    shots <<
      if s == 'X'
        10
      else
        s.to_i
      end
  elsif s == 'X'
    shots << 10
    shots << 0
    num_count += 2
  else
    shots << s.to_i
    num_count += 1
  end
end

# 1フレームにつき2回投げるので1つの配列に数字が2つずつ入るように分割する
frames = shots.each_slice(2).to_a

# 最終フレームを3投しているときは11フレームできるので11フレームを10フレームに結合し、11フレームは削除する
if frames.size > 10
  frames[-2].concat frames[-1]
  frames.delete_at(-1)
end

point = 0
frames.each_with_index do |frame, index|
  point +=
    if index < 8 && frame[0] == 10 && frames[index + 1][0] == 10
      frame.sum + frames[index + 1].sum + frames[index + 2][0]
    elsif frame[0] == 10 && frame != frames[-1]
      frame.sum + frames[index + 1][0] + frames[index + 1][1]
    elsif frame.sum == 10 && frame != frames[-1]
      frame.sum + frames[index + 1][0]
    else
      frame.sum
    end
end

puts point
