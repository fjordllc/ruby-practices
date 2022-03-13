#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'

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

# 数を2つずつに分けてframes配列に入れている
frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
prev_status = ''
frames.each do |frame|
  # binding.pry
  point +=
    case prev_status
    when 'spare'
      frame[0] + frame.sum
    when 'strike'
      frame.sum * 2
    else
      frame.sum
    end

  prev_status =
    if frame[0] == 10 # strike
      'strike'
    elsif frame.sum == 10 # spare
      'spare'
    else
      ''
    end
end
puts point
