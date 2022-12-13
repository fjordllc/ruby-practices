# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

frames = []
one_frame = []
last_frame = []

scores.each do |s|
  if s == 'X' && frames.size >= 9
    last_frame << 10
  elsif frames.size >= 9
    last_frame << s.to_i
  elsif s == 'X'
    one_frame << 10
  else
    one_frame << s.to_i
  end
  next if one_frame.size == 1 && one_frame != [10]

  frames << one_frame
  one_frame = []
end

frames.delete([])
frames.push(last_frame)

numbers = [*1..10]
result = [numbers, frames].transpose.to_h

point = 0
result.each do |number, frame|
  point += if frame[0] == 10 && number != 10
             if result.fetch(number + 1)[0] == 10 && number != 9
               10 + result.fetch(number + 1)[0] + result.fetch(number + 2)[0]
             else
               10 + result.fetch(number + 1)[0] + result.fetch(number + 1)[1]
             end
           elsif frame.sum == 10 && number != 10
             10 + result.fetch(number + 1)[0]
           else
             frame.sum
           end
end

p point
