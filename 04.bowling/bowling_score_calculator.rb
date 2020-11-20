# frozen_string_literal: true

score = ARGV[0]
scores = score.chars

shots = []
scores.each.with_index do |s, i|
  if s == 'X'
    kind_of_score = 'strike' if i.zero? # スコアの最初がXは必ずストライク

    kind_of_score = 'strike' if scores[i - 1] == 'X' || scores[i - 1].to_i != 0 # 前のスコアが0じゃないXは必ずストライク

    if scores[i - 1] != 'X' && scores[i - 1].to_i.zero?
      kind_of_score = 'spare' if i == 1 # 2投目がXで1投目が0なら必ずスペア

      kind_of_score = 'spare' if scores[i - 2] == 'X' # 2投前がXなら必ずスペア

      kind_of_score = 'strike' if i > 1 && scores[i - 2] != 'X' # 2投前が[0-9]なら必ずストライク
    end
  else
    kind_of_score = 'other'
  end

  case kind_of_score
  when 'strike'
    shots << 10
    shots << 0
  when 'spare'
    shots << 10
  else
    shots << s.to_i
  end
end

# フレーム毎に分割
frames = []
shots.each_slice(2) do |s|
  frames << s
end

# 11フレーム以上存在する場合は10フレーム目に3投目が投げられていることになるので10フレーム以降を10フレーム目にまとめる
case frames.length
when 12
  frames[-3] = [10, 10, 10]
  frames.pop(2)
when 11
  frames[-2] = frames.last(2).flatten
  frames.pop
end

point = 0
frames.each_cons(3) do |(current_frame, next_frame, after_next_frame)|
  point += if current_frame[0] == 10 && next_frame[0] == 10 # 連続strike
             10 + next_frame[0] + after_next_frame[0]
           elsif current_frame[0] == 10 # strike
             10 + next_frame.sum
           elsif current_frame.sum == 10 # spare
             10 + next_frame[0]
           else
             current_frame.sum
           end
end

# frames.each_cons(3)で処理できなかった残り２フレーム分を処理
point += if frames[-2][0] == 10 # strike
           10 + frames.last[0] + frames.last[1]
         elsif frames[-2].sum == 10 # spare
           10 + frames.last[0]
         else
           frames[-2].sum
         end

point += frames.last.sum

puts point
