require 'rubocop'

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
  frames << s
end

point = 0
frame_index = 0

frames.each_with_index do |frame, index|
  if frame_index >= 9
    point += frame.sum
  else
    if frame[0] == 10
      point += 10 + frames[index + 1][0] + frames[index + 1][1]
      frame_index += 1
    elsif frame.sum == 10
      point += 10 + frames[index + 1][0]
      frame_index += 1
    else
      point += frame.sum
      frame_index += 1
    end
  end
end

puts point
