# frozen_string_literal: true

scores = ARGV[0].split(',')
scores.map! { |s| s == 'X' ? '10' : s.to_i }

frames = Array.new(10) { [] }
frames.each_with_index do |frame, i|
  if i == 9
    frame.concat(scores)
  elsif scores[0] == 10
    frame << 10
    scores.delete_at(0)
  else
    frame.concat(scores[0, 2])
    2.times { scores.delete_at(0) }
  end
end

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
