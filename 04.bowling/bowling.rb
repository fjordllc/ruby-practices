#!/usr/bin/env ruby

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

# frames = []
# shots.each_slice(2) do |s|
#   frames << s
# end

frames = []
shots.each_slice(2).with_index do |s, idx|
  frames << s if idx <= 8
end
frame_of_tenth_shot_including_nil = [shots[18], shots[19], shots[20], shots[21], shots[22], shots[23]]
frame_of_tenth_shot = frame_of_tenth_shot_including_nil.map {|tenth_shot| tenth_shot.to_i}
frames << frame_of_tenth_shot

# frames => [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10, 0], [9, 1], [8, 0], [10, 0], [6, 4], [6, 4, 0, 0, 0, 0]]

p frames

point = 0
frames.each_with_index do |frame, idx|
  if idx <= 7
    if frame[0] == 10 # strike
      # point += 30
      if frames[idx+1][0] == 10
        # point += frames[idx].sum + frames[idx+1].sum + frames[idx+2][0]
        point += 10 + 10 + frames[idx+2][0]

      else # frames[idx+1] == [1,1]など
        point += 10 + frames[idx+1].sum
      end
    elsif frame.sum == 10 # spare
      # point += frame[0] + 10
      point += frames[idx].sum + frames[idx+1][0]
    else #strikeでもspareでもない場合
      point += frame.sum
    end
  elsif idx == 8
    if frame[0] == 10 # strike
      if frames[9][0] == 10
        point += 10 + 10 + frames[9][2]
      else
        point += 10 + frames[9][0] + frames[9][1]
      end
    elsif frame.sum == 10 # spare
      point += 10 + frames[9][0]
    else #strikeでもspareでもない場合
      point += frame.sum
    end
  else # idx == 9の場合、即ち、10フレーム目の場合
    point += frame.sum
  end
end
puts point
