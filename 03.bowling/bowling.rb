# frozen_string_literal: true

require 'debug'
# require 'bundler/setup'
class Array
  def strike?
    return true if self[0] == 10

    false
  end

  def spare?
    return true if sum == 10

    false
  end
end

score = ARGV[0]
scores = score.split(',')
shots = []

# オプションから入力したスコアを計算できる形にする
scores.each do |s|
  if %w[x X].include?(s)
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
# フレームごとに点を分割する
frames = []
shots.each_slice(2) do |s|
  frames << s
end
p frames

# 点数を計算する
point = 0
frames.each_with_index do |frame, count|
  # binding.break
  # 10フレームの計算のために仮に作り出した
  if count >= 9
    point += frame.sum
    next
  end

  point +=
    if frame.strike?
      if frames[count + 1][0] == 10
        30 if frames[count + 2][0] == 10
        (20 + frames[count + 2][0])
      else
        10 + frames[count + 1].sum
      end

    elsif frame.spare?
      10 + frames[count + 1][0]
    else
      frame.sum
    end
end

puts point
