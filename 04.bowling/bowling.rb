#!/usr/bin/env ruby
score = ARGV[0]
scores = score.chars.map! { |n| n == 'X' ? 10 : n.to_i }
frame = []
frames = []
frame_count = 0

scores.each do |score_temp|
  frame << score_temp
  if frame_count + 1 <= 9
    if frame.length == 1 && frame[0] == 10
      # 1投目で1本倒した(つまりストライク)の場合は、後ろに0を追加して
      # 配列framesに格納
      frame << 0
      frames << frame
      frame = []
      frame_count += 1
    elsif frame.length == 2
      # 1フレーム分の得点がまとまった場合は、配列framesに格納
      frames << frame
      frame = []
      frame_count += 1
    end
  elsif frame_count + 1 == 10
    # 10フレーム目はそのまま配列framesに代入するだけ
    frames << frame
    frame_count += 1
  end
end

point = 0
# フレーム数を表すインデックス変数
frames_index = 0

frames.each do |frame_tmp|
  point +=
    if frames_index + 1 == 10
      # 10フレーム目のみは単純に加算する
      frame_tmp.sum
    elsif frame_tmp.sum == 10 && frame_tmp[0] != 10
      # スペアの場合
      # 次フレームの1投目の得点を追加で加算
      frame_tmp.sum + frames[frames_index + 1][0]
    elsif frame_tmp[0] == 10
      # ストライクの場合
      # 次のフレームの1,2投目の合計を追加で加算
      if (frames[frames_index + 1][1]).zero? && frames_index + 1 != 9
        # ストライクが連続した場合は、計算を合わせるために2フレーム先の得点を足す
        # ただし9フレーム目のみは2フレーム先はないので行わない
        frame_tmp.sum + frames[frames_index + 1][0] + frames[frames_index + 2][0]
      else
        frame_tmp.sum + frames[frames_index + 1][0] + frames[frames_index + 1][1]
      end
    else
      # スペアでもストライクでもない場合は、単純に1フレームの合計値を加算
      frame_tmp.sum
    end
  # フレームを1つ進める
  frames_index += 1
end

# 総合得点を出力
p point
