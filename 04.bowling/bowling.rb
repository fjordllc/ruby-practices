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

frames.first(10).each_with_index do |frame, i|
  next_frame = frames[i + 1]
  afternext_frame = frames[i + 2]

  if frame[0] == 10 # strike
    if next_frame[0] == 10
      break if afternext_frame.nil?

      point += afternext_frame[0]
    end

    point += 10
    point += next_frame.sum

  elsif frame.sum == 10 # spare
    point += 10
    point += next_frame[0]

  else
    point += frame.sum
  end
end
puts point

