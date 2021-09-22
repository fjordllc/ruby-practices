#!/usr/bin/env ruby
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

frames = shots.each_slice(2).to_a

point = 0
STRIKE = 10
frames[0..8].each_with_index do |frame, idx|
  point +=  if frame[0] == STRIKE && frames[idx + 1][0] == STRIKE
              10 + frames[idx + 1][0] + frames[idx + 2][0]
            elsif frame[0] == STRIKE
              10 + frames[idx + 1].sum
            elsif frame.sum == 10
              10 + frames[idx + 1][0]
            else
              frame.sum
            end
end

point += if frames[9][0] == STRIKE && frames[10][0] == STRIKE
           10 + frames[10].sum + frames[11].sum
         elsif frames[9][0] == STRIKE
           10 + frames[10].sum
         elsif frames[9].sum == 10
           10 + frames[10].sum
         else
           frames[9].sum
         end

puts point
