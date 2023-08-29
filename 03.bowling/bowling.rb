# frozen_string_literal: true

require 'debug'
require 'bundler/setup'

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

# 　以下each_consイテレータのために仮に１１回を作り出す
if frames.count == 10
  2.times { frames << [0, 0] }
else
  frames << [0, 0]
end

p frames

# 点数を計算する
point = 0
frames.each_cons(3).each.with_index(1) do |frame, count|
  # 10フレームの計算のために仮に作り出した
  break if count == 11

  if frame[0][0] == 10
    if frame[1][0] == 10
      # ２連続でストライクがあった場合の例外（９フレームとターキーの真ん中）
      if count == 9 || frame[2][0] != 10
        point += (20 + frame[2][0])
      else
        point += 30
      end
    else
      point += (10 + frame[1].sum)
    end
  elsif frame[0].sum == 10
    point += (10 + frame[1][0])
  else
    point += frame[0].sum
  end
end

puts point
