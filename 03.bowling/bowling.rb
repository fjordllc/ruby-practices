# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
last_frame = []
# 9フレームまではshots,10フレームはlast_frameへ追加
scores.each do |s|
  if s == 'X' && shots.size < 18
    shots << 10
    shots << 0
  elsif s == 'X' && shots.size >= 18
    last_frame << 10
  elsif shots.size >= 18
    last_frame << s.to_i
  else
    shots << s.to_i
  end
end

# framesへ１フレームずつ分割して追加
frames = []
shots.each_slice(2) do |s|
  frames << s
end

# ストライクは[10]へ表示修正
frames.each do |frame|
  frame.pop if frame == [10, 0]
end
# 10フレーム追加
frames.push(last_frame)

# 全てのフレームをナンバリング
numbers = [*1..10]
result = [numbers, frames].transpose.to_h

# 点数計算
point = 0
result.each do |number, frame|
  point += if frame[0] == 10 && number != 10 # 1~9フレームのストライク
             if result.fetch(number + 1)[0] == 10 && number != 9
               10 + result.fetch(number + 1)[0] + result.fetch(number + 2)[0]
             else
               10 + result.fetch(number + 1)[0] + result.fetch(number + 1)[1]
             end
           elsif frame.sum == 10 && number != 10 # スペア
             10 + result.fetch(number + 1)[0]
           else # それ以外
             frame.sum
           end
end

p point
