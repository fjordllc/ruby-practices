# frozen_string_literal: true

score = ARGV[0]
scores = score.chars

shots = []
scores.each.with_index do |s, i|
  if s == 'X'
    kind_of_score = 'strike' if i.zero? # スコアの最初がXは必ずストライク

    kind_of_score = 'spare' if i == 1 && scores[0] != 'X' && scores[0].to_i.zero? # 2投目でスペアの場合は1投目が必ず0になっている

    # 引数の3番目以降に存在するXはストライクかスペアか判断できないのでshotsを見る
    kind_of_score = 'spare' if i > 1 && shots.length.odd? # shotsの配列数が奇数ならフレームの2投目がXなのでスペア

    kind_of_score = 'spare' if shots.length > 18 # 19投目以降はすべてスペア扱いとする

    kind_of_score ||= 'strike' # 上記の条件に一致しない場合はストライク
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

# 11フレーム目が存在する場合は10フレーム目に3投目が投げられていることになるので10フレーム目にまとめる
if frames.length > 10
  frames[-2] = if frames.last.length == 2 # 最後のフレームで3連続ストライク
                 [frames[-2].sum, frames.last[0], frames.last[1]]
               else
                 [frames[-2][0], frames[-2][1], frames.last[0]]
               end
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
