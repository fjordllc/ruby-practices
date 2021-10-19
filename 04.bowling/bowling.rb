#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

score_pin = ARGV[0]
scores = score_pin.split(',').map { |s| s == 'X' ? 10 : s.to_i }

# フレーム作成
shots = []
frames = []
frame_count = 0
scores.each do |score|
  shots << score
  if frame_count + 1 <= 9
    if shots[0] == 10 || shots.size == 2
      frames << shots
      shots = []
      frame_count += 1
    end
  elsif frame_count + 1 == 10
    frames << shots
    frame_count += 1
  end
end

# スコア計算
total_point = 0
frames.each_with_index do |frame, n|
  total_point += if frame == [10] && frames[n + 1] == [10]
                   20 + frames[n + 2][0]
                 elsif frame == [10]
                   10 + frames[n + 1][0] + frames[n + 1][1]
                 elsif frame.sum == 10 && n != 9
                   10 + frames[n + 1][0]
                 else
                   frame.sum
                 end
end
puts total_point
