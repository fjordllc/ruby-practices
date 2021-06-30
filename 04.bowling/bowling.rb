#!/usr/bin/env ruby
# frozen_string_literal: true

def main(score_text)
  scores = score_text.split(',')
  shots = []
  scores.each do |score|
    if score == 'X'
      shots << 10
      shots << 0
    else
      shots << score.to_i
    end
  end
  each_shot_score_sum = shots.sum

  frames = []
  shots.each_slice(2) do |s|
    frames << s
  end
  bonus_point = calc_bonus_point(frames)
  each_shot_score_sum + bonus_point
end

def calc_bonus_point(frames)
  bonus_point = 0
  frames[0..8].each_with_index do |_frame, n|
    spare = frames[n].sum == 10 && frames[n][0] != 10
    strike = frames[n][0] == 10
    strike_after_strike = frames[n + 1][0] == 10
    bonus_point += if spare
                     frames[n + 1][0]
                   elsif strike
                     if strike_after_strike
                       frames[n + 1][0] + frames[n + 2][0]
                     else
                       frames[n + 1].sum
                     end
                   else
                     0
                   end
  end
  bonus_point
end

puts main(ARGV[0]) if __FILE__ == $PROGRAM_NAME
