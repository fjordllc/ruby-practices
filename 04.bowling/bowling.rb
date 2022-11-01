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

sum_score =
  frames.each_with_index.sum do |s, f|
    if f + 1 >= 10
      s.sum
    elsif s[0] == 10
      if frames[f + 1][0] == 10
        20 + frames[f + 2][0]
      else
        10 + frames[f + 1].sum
      end
    elsif s.sum == 10
      10 + frames[f + 1][0]
    else
      s.sum
    end
  end

p sum_score
