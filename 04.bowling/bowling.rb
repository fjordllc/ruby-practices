#!/usr/bin/env ruby
score = ARGV[0]
scores = score.chars
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

p frames

point = 0
#フレーム数を表すインデックス変数
frames_index = 0

frames.each do |frame|
    #1フレームごとの合計得点を格納
#    point = point + frames[i].sum
    if frames[frames_index].sum == 10
        #1フレームの合計ピン数が10(スペア)の場合
        #次のフレームの1投目のピン数を加算
        point = point + frames[frames_index + 1][0]
    elsif frames[frames_index][0] = 10
        #ストライクの場合
        #次フレームの1,2投目のピン数を加算
        point = point + frames[1].sum
    else
        point = point + frames[frames_index].sum
    end
    #次のフレームに進める
    frames_index = frames_index + 1
    p point
end

p point

#ここから下は参考プログラム。
#一応残しておいて、後で消す。
=begin
point = 0
frames.each do |frame|
  if frame[0] == 10 # strike
    point += 30
  elsif frame.sum == 10 # spare
    point += frame[0] + 10
  else
    point += frame.sum
  end
end
puts point
=end
