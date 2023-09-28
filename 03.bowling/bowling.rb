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
  if shots.size > 20
    break if
    frames.size == 9
  else
    frames.size == 10
  end
  frames << s
end

case shots.size
when 21
  frame10 = [shots[-3], shots[-2], shots[-1]]
  frames.push(frame10)
when 22
  frame10 = [shots[-4], shots[-2], shots[-1]]
  frames.push(frame10)
when 24
  frame10 = [shots[-6], shots[-4], shots[-2]]
  frames.push(frame10)
end

point = 0

frames.each_with_index do |frame, index|
  point += if frame[0] == 10 && frames[index + 1][0] != 10
             10 + frames[index + 1][0] + frames[index + 1][1]
           elsif frame[0] == 10 && frames[index + 1][0] == 10 && index != 8
             10 + frames[index + 1][0] + frames[index + 2][0]
           elsif frame[0] == 10 && frames[index + 1][0] == 10
             10 + frames[index + 1][0] + frames[index + 1][1]
           elsif frame.sum == 10 # spare
             10 + frames[index + 1][0]
           else
             frame.sum
           end
  break if index == 8
end

point += frames[9].sum

puts point
