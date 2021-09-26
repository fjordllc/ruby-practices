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
  exception =
    if s[0] == 10
      :strike
    elsif s.sum == 10
      :spare
    else
      :none
    end
  score_exceptions << exception
end

score_exceptions.each_with_index do |e, idx|
  case e
  when :strike
    if idx <= 8
      frames[idx][1] = frames[idx + 1][0]
      frames[idx][2] =
        if score_exceptions[idx + 1] == :strike
          frames[idx + 2][0]
        else
          frames[idx + 1][1]
        end
    elsif idx == 9
      frames[9][1] = frames[10][0]
      if frames[10][0] == 10
        frames[9][2] = frames[11][0]
        2.times { frames.delete_at(10) }
      end
    end
  when :spare
    frames[idx][2] = frames[idx + 1][0]
    frames.delete_at(idx + 1) if idx > 8
  end
end

point = 0
frames.each do |frame|
  point += frame.sum
end

puts point
