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
  frames << s
end

point = 0
frames.each_with_index do |frame, n|
  if n <= 8
    point += frame.sum
    if frame[0] == 10
      point += frames[n + 1].sum
      point += frames[n + 2][0] if frames[n + 1][0] == 10
    elsif frame[0] + frame[1] == 10
      point += frames[n + 1][0]
    end
  end

  point += frame.sum if n > 8
end

puts point
