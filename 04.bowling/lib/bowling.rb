#!/usr/bin/env ruby
# frozen_string_literal: true

def split_each_shot(scores)
  shots = []
  scores.each do |s|
    if s == 'X'
      shots << 10
      shots << 0
    else
      shots << s.to_i
    end
  end
  shots
end

def slice_each_frame(shots)
  frames = []
  shots.each_slice(2).with_index do |s, index|
    if index > 9
      if frames.last == [10, 0]
        frames[index - 1] = [frames.last.first, s.first]
      else
        frames.last << s.first
      end
    else
      frames << s
    end
  end
  frames
end

def calculate_point(frames)
  point = 0
  frames.each_with_index do |frame, index|
    point += if index != frames.size - 1 && frame[0] == 10 # strike
               calculate_strike_point(frames, frame, index)
             elsif frame[1] != 0 && frame.sum == 10 # spare
               frame.sum + frames[index + 1][0]
             else
               frame.sum
             end
  end
  p point
end

def calculate_strike_point(frames, frame, index)
  if index + 1 != frames.size - 1 && frames[index + 1] == [10, 0]
    frame.sum + frames[index + 1][0] + frames[index + 2][0]
  else
    frame.sum + frames[index + 1][0..1].sum
  end
end

def main(score)
  if score
    scores = score.split(',')
    shots = split_each_shot(scores)
    frames = slice_each_frame(shots)
    calculate_point(frames)
  else
    p '結果を入力してください。'
  end
end

score = ARGV[0]
main(score)
