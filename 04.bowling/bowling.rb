#!/usr/bin/env ruby
# frozen_string_literal: true

def main(score)
  scores = score.split(',')
  shots = []
  scores.each do |s|
    case s
    when 'X'
      shots << 10
      shots << 0
    when 'S'
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
  add_point
  each_shot_score_sum + @add_point
end

def add_point
  @add_point = 0

  @frames[0..8].each_with_index do |_frame, n|
    @add_point += if (@frames[n].sum == 10) && (@frames[n][0] != 10)
                    @frames[n + 1][0]
                  elsif (@frames[n][0] == 10) && (@frames[n + 1][0] == 10)
                    @frames[n + 1][0] + @frames[n + 2][0]
                  elsif @frames[n][0] == 10
                    @frames[n + 1].sum
                  else
                    0
                  end
  end
end

puts main(ARGV[0]) if __FILE__ == $PROGRAM_NAME
