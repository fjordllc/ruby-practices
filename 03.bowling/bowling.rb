require 'debug'

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
    frame_10 = []
    18.upto(shots.length - 1) { |i|
      frame_10 << shots[i] unless shots[i] == 0
    }
    frames << frame_10
    break
  end
end

point = 0
frames.each_with_index do |frame, i|
  if i < 9
    if frame[0] == 10 # strike
      if frames[(i + 1)][0] == 10
        point += 20 + (frames[(i + 2)] ? frames[(i + 2)][0] : 0)
      else
        point += 10 + frames[(i + 1)][0] + frames[(i + 2)][0]
      end
    elsif frame.sum == 10 # spare
      point += 10 + frames[(i + 1)][0]
    else
      point += frame.sum
    end
  elsif i == 9
    point += frame.sum
    break
  end
end
puts point
