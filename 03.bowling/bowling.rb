#!/usr/bin/env ruby
# frozen_string_literal: true

def convert_point(point)
  if point == 'X'
    10
  else
    point.to_i
  end
end

points = ARGV[0].split(',')
score = 0
10.times do
  frame_score = 0
  strike_spare = ''
  (1..2).each do |throwing|
    throwing_point = convert_point(points[0])
    frame_score += throwing_point
    if throwing == 1 && throwing_point == 10
      strike_spare = 'strike'
      frame_score += convert_point(points[1])
      frame_score += convert_point(points[2])
    elsif throwing == 2 && frame_score == 10 && strike_spare.empty?
      strike_spare = 'spare'
      frame_score += convert_point(points[1])
    end
    points.shift
    break if throwing == 2 || strike_spare == 'strike'
  end
  score += frame_score
end
puts score
