#! /usr/bin/env ruby
# frozen_string_literal: true

shoots = ARGV[0].split(',')

# スコアをフレーム毎に分割する
frame_points = []
frames = []
shoots.each do |shoot|
  # 10フレーム目作成以後のスコアはすべて10フレーム目に追加
  if frames.size == 10
    frames.last.push(shoot == 'X' ? 10 : shoot.to_i)
    next
  end

  frame_points.push(shoot == 'X' ? 10 : shoot.to_i)

  if shoot == 'X'
    frames << frame_points
    frame_points = []
  elsif frame_points.size == 2
    frames << frame_points
    frame_points = []
  end
end

points = 0
frames.each_with_index do |frame, index|
  # 最終フレーム分の加算
  if index == 9
    points += frames[index].sum
    next
  end

  # 1~9フレーム分の加算
  points += (
    # ストライクの場合
    if frame.size == 1
      if frames[index + 1].size == 1
        frame.first + frames[index + 1].first + frames[index + 2].first
      else
        frame.first + frames[index + 1][0] + frames[index + 1][1]
      end
    # スペアの場合
    elsif frame.sum == 10
      frame.sum + frames[index + 1].first
    # その他の場合
    else
      frame.sum
    end
  )
end

puts points
