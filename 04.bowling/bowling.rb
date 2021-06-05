#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  elsif s == 'S'
    shots << 10
  else
    shots << s.to_i
  end
end
each_shot_score_sum = shots.sum

@frames = []
shots.each_slice(2) do |s|
  @frames << s
end

def add_point
  @add_point = 0

  @frames[0..8].each_with_index do |_frame, n|
    if (@frames[n].sum == 10) && (@frames[n][0] != 10)
      @add_point += @frames[n + 1][0]
    elsif (@frames[n][0] == 10) && (@frames[n + 1][0] == 10)
      @add_point += @frames[n + 1][0] + @frames[n + 2][0]
    elsif @frames[n][0] == 10
      @add_point += @frames[n + 1].sum
    else
      @add_point += 0
    end
  end
end

add_point
puts each_shot_score_sum + @add_point
