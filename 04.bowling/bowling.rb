#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0].dup
scores = score.split(',')

sub = []
scores.each do |s| # Xを[10, 0]に変換して並べる
  if s == 'X' # strike
    sub << 10
    sub << 0
  else
    sub << s.to_i
  end
end

total_inning = 2 * 9
normal_score = sub[0...total_inning]
normal_frames = normal_score.each_slice(2).to_a

last_score = sub[total_inning..] # 10投目の配列を入手
last_frame = []

until last_score.empty?
  last_frame << (score = last_score.shift)
  last_score.shift if score == 10
end

frames = normal_frames.push(last_frame) # 全てのフレーム

point = 0

frames.each_with_index do |frame, i|
  point += if i == 9 # 10投目
             frame.sum
           elsif i < 8 && frame[0] == 10 && frames[i + 1][0] == 10 # 連続ストライク
             10 + frames[i + 1][0] + frames[i + 2][0]
           elsif frame[0] == 10 # ストライク
             10 + frames[i + 1][0] + frames[i + 1][1]
           elsif frame.sum == 10 # スペア
             10 + frames[i + 1][0]
           else
             frame.sum
           end
end

puts point
