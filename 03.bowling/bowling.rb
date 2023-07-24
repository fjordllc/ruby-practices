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
shots.each_slice(2).with_index do |s, index|
  if index < 9
    frames << s
  elsif index == 9
    frame10 = []
    18.upto(shots.length - 1) do |i|
      frame10 << shots[i] unless shots[i].zero?
    end
    frames << frame10
    break
  end
end

def calc_strike_point(time, frames)
  if frames[time + 1][0] == 10
    if time < 8
      20 + (frames[time + 2] ? frames[time + 2][0] : 0)
    else
      20 + frames[time + 1][1]
    end
  else
    time < 8 ? 10 + frames[time + 1].sum : 10 + frames[time + 1][0] + frames[time + 1][1]
  end
end

point = 0
frames.each_with_index do |frame, i|
  point += if i < 9
             if frame[0] == 10 # strike
               calc_strike_point(i, frames)
             elsif frame.sum == 10 # spare
               10 + frames[(i + 1)][0]
             else
               frame.sum
             end
           elsif i == 9
             frame.sum
           end
end
puts point
