#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << if s == [10, 0]
              [s.shift]
            else
              s
            end

  frames[9].concat(frames[10]) if frames[10]
  frames.slice!(10)
end

point = 0
frames.each_with_index do |frame, i|
  if i == 9 #10フレーム目は単純に合計する
    point += frame.sum
  elsif frame[0] == 10 # ストライクの場合の分岐
    point += frames[i + 1][0]
    if frames[i + 1][1].nil? # ストライクの次の次の投球がストライクの場合
      point += frames[i + 2][0]
    else
      point += frames[i + 1][1]
    end
  elsif frame.sum == 10 # スペアの場合の分岐
    point += frames[i + 1][0]
  end
  point += frame.sum if i != 9
end

puts point
