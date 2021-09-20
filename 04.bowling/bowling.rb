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

frames = []
score_exceptions = []
exception = ''
shots.each_slice(2) do |s|
  frames << s
  frames.each do |frame|
    exception =
      if frame[0] == 10
        'strike'
      elsif frame.sum == 10
        'spare'
      else
        'none'
      end
  end
  score_exceptions << exception
end

array_number = 0
score_exceptions.each do |e|
  if array_number <= 8 && e == 'strike' && score_exceptions[array_number + 1] == 'strike'
    frames[array_number][1] = frames[array_number + 1][0]
    frames[array_number][2] = frames[array_number + 2][0]
  elsif array_number <= 8 && e == 'strike'
    frames[array_number][1] = frames[array_number + 1][0]
    frames[array_number][2] = frames[array_number + 1][1]
  elsif array_number <= 8 && e == 'spare'
    frames[array_number][2] = frames[array_number + 1][0]
  end
  if array_number == 9 && e == 'strike'
    frames[9][1] = frames[10][0]
    if frames[10][0] == 10 && e == 'strike'
      frames[9][2] = frames[11][0]
      2.times { frames.delete_at(10) }
    elsif e == 'strike'
      frames[9][2] = frames[10][1]
      2.times { frames.delete_at(10) }
    elsif e == 'spare'
      frames[array_number][2] = frames[array_number + 1][0]
      frames.delete_at(array_number + 1)
    end
  end
  array_number += 1
end

point = 0
frames.each do |frame|
  point += frame.sum
end

puts point
