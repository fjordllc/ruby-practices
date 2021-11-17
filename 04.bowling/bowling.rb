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
  if frame[0] == 10 && i != 9 # strikeかつ、10フレーム目は除外
    i += 1
    point += frames[i][0]

    if frames[i][1].nil? # ストライクの次の次の投球がストライクの場合
      i += 1
      point += frames[i][0]
    else
      point += frames[i][1]
    end
  elsif frame.sum == 10 && i != 9 # spareかつ、10フレーム目は除外
    i += 1
    point += frames[i][0]
  end
  point += frame.sum
end

puts point
