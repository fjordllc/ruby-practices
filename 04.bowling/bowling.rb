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

normal_score = []
i = 0
while i <= 17 # 9投目までの配列を入手
  normal_score << sub[i].to_i
  i += 1
end
normal_frames = []
normal_score.each_slice(2) do |nf|
  normal_frames << nf
end

last_score = sub.slice(18, sub.size) # 10投目の配列を入手
last_frames = []
j = 0
while j < last_score.size
  last_frames << last_score[j].to_i
  j += 1 if last_score[j].to_i == 10 # ストライクならk+=1して0を飛ばす
  j += 1
end

frames = normal_frames.push(last_frames) # 全てのフレーム

point = 0
k = 0
while k < 8 # 1〜8投目の計算
  point += if frames[k][0] == 10 && frames[k + 1][0] == 10 # 連続ストライクの場合
             10 + frames[k + 1][0] + frames[k + 2][0]
           elsif frames[k][0] == 10
             10 + frames[k + 1][0] + frames[k + 1][1]
           elsif frames[k].sum == 10 # スペアの場合
             10 + frames[k + 1][0]
           else
             frames[k].sum
           end
  k += 1
end

# 9投目の計算
point += if frames[8][0] == 10
           10 + frames[8 + 1][0] + frames[8 + 1][1]
         elsif frames[8].sum == 10
           10 + frames[8 + 1][0]
         else
           frames[8].sum
         end

point += frames[9].sum # 10投目の計算を追加

puts point
