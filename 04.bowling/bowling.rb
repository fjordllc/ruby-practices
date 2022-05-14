# !/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',') # 取得した値をカンマ(,)で文字列を分割して結果を配列に格納
shots = [] # 空の変数shotsを作成、取得された値が代入される

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# フレーム毎に分割
frames = shots.each_slice(2).to_a

point = frames.each_with_index.sum do |f, i|
  if i <= 8
    if f[0] == 10
      frames[i + 1][0] == 10 ? 10 + 10 + frames[i + 2][0] : 10 + frames[i + 1].sum
    elsif f.sum == 10
      10 + frames[i + 1][0]
    else
      f.sum
    end
  else
    f.sum
  end
end

puts point
