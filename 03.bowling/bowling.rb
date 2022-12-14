# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

frames = []
current_frame = []
last_frame = []

scores.each do |s|
  if s == 'X' && frames.size >= 9
    last_frame << 10
  elsif frames.size >= 9
    last_frame << s.to_i
  elsif s == 'X'
    current_frame << 10
  else
    current_frame << s.to_i
  end
  next if current_frame.size == 1 && current_frame != [10]

  frames << current_frame
  current_frame = []
end

frames.delete([])
frames.push(last_frame)

point = 0
frames.each_with_index do |frame, i|
  point += if frame[0] == 10 && i != 9
             if frames[i + 1][0] == 10 && i != 8
               10 + frames[i + 1][0] + frames[i + 2][0]
             else
               10 + frames[i + 1][0] + frames[i + 1][1]
             end
           elsif frame.sum == 10 && i != 9
             10 + frames[i + 1][0]
           else
             frame.sum
           end
end

p point
