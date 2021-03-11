#!/usr/bin/env ruby
# frozen_string_literal: true

input_score = ARGV[0]
input_scores = input_score.chars.map! { |n| n == 'X' ? 10 : n.to_i }
frame = []
frames = []
frame_count = 1

input_scores.each do |score|
  frame << score
  if frame_count <= 9
    if frame.length == 1 && frame[0] == 10
      # 1投目で10本倒した(つまりストライク)の場合は、後ろに0を追加して
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
  elsif frame_count == 10
    # 10フレーム目はそのまま配列framesに代入するだけ
    frames << frame
    frame_count += 1
  end
end

point = 0

frames.each_with_index do |frame, i|
  # フレーム数を表す変数を配列のインデックスにすると参照がずれるため変数を分けている
  frames_number = i + 1
  point +=
    if frames_number == 10
      # 10フレーム目のみは単純に加算する
      frame.sum
    elsif frame.sum == 10 && frame[0] != 10
      # スペアの場合
      # 次フレームの1投目の得点を追加で加算
      frame.sum + frames[i + 1][0]
    elsif frame[0] == 10
      # ストライクの場合
      # 次のフレームの1,2投目の合計を追加で加算
      if (frames[i + 1][1]).zero? && frames_number != 9
        # ストライクが連続した場合は、計算を合わせるために2フレーム先の得点を足す
        # ただし9フレーム目のみは2フレーム先はないので行わない
        frame.sum + frames[i + 1][0] + frames[i + 2][0]
      else
        frame.sum + frames[i + 1][0] + frames[i + 1][1]
      end
    else
      # スペアでもストライクでもない場合は、単純に1フレームの合計値を加算
      frame.sum
    end
end

puts point
