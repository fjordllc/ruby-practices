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

  frames = shots.each_slice(2).to_a
  bonus_point = calc_bonus_point(frames)
  each_shot_score_sum + bonus_point
end

def calc_bonus_point(frames)
  bonus_point = 0
  0.upto(8) do |n|
    spare = frames[n].sum == 10 && frames[n][0] != 10
    strike = frames[n][0] == 10
    strike_after_strike = frames[n + 1][0] == 10
    if spare
      bonus_point += frames[n + 1][0]
    elsif strike
      bonus_point += frames[n + 1].sum
      bonus_point += frames[n + 2][0] if strike_after_strike
    end
  end
  bonus_point
end

puts main(ARGV[0]) if __FILE__ == $PROGRAM_NAME
