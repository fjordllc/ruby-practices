#!/usr/bin/env ruby
def convert_point(point)
  if point == 'X'
    point = 10
  else
    point = point.to_i
  end
  point
end

points = ARGV[0].split(',')
score = 0
(1..10).each do |frame|
  frame_score = 0
  strike_spare = ""
  (1..2).each do |throwing|
    throwing_point = convert_point(points[0])
    frame_score += throwing_point
    if throwing == 1 && throwing_point == 10
      strike_spare = "strike"
      frame_score += convert_point(points[1])
      frame_score += convert_point(points[2])
    elsif throwing == 2 && frame_score == 10 && strike_spare.empty?
      strike_spare = "spare"
      frame_score += convert_point(points[1])
    end
    points.shift
    if throwing == 2 || strike_spare == "strike" 
      break
    end
  end
  score += frame_score
end
puts score
