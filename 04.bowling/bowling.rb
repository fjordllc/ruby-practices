# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if shots.length >= 18 && s == 'X'
    shots << 10
  elsif s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  if frames.length == 10
    frames[9] << shot[-1]
  elsif shot == [10, 0] && frames.length != 9
    frames << [shot.shift]
  else
    frames << shot
  end
end

point = 0
frames.each_with_index do |frame, i|
  if i == 9
    point += frame.sum
  elsif frame[0] == 10
    if frames[i + 1][0] == 10 && i == 8
      point += frames[i + 1][0] + frames[i + 1][1] + 10
    elsif frames[i + 1][0] == 10
      point += frames[i + 1][0] + frames[i + 2][0] + 10
    else
      frames[i + 1][0] + frames[i + 1][1] + 10
    end
  elsif frame.sum == 10
    point += frames[i + 1][0] + 10
  else
    frame.sum
  end
end

puts point
