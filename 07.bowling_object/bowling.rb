#!/usr/bin/env ruby
# frozen_string_literal: true

module Bowling
  class Game
    def initialize(marks)
      @frames = parse_marks(marks)
    end

    def score
      score_for(frames)
    end

    private

    STRIKE = 10

    attr_reader :frames

    def parse_marks(marks)
      pins = marks.split(',').map { |m| m == 'X' ? STRIKE : m.to_i }
      frames = []
      9.times do
        rolls = pins.shift(2)
        if rolls.first == STRIKE
          frames << [rolls.first, nil] # 2投目は投げていない
          pins.unshift(rolls.last) # 取りすぎなので戻す
        else
          frames << rolls
        end
      end
      frames << pins # 最後に残ったのが10フレーム目
    end

    # ボーナス対象フレームがストライクだった場合、さらにその次のフレームの1投目がボーナス対象になる
    def bonus_rolls(count, frames, idx)
      frames[idx + 1].take(count).sum { |roll| roll.nil? ? frames[idx + 2].first : roll }
    end

    def strike_with_bonus(frames, idx)
      STRIKE + bonus_rolls(2, frames, idx)
    end

    def spare_with_bonus(frames, idx)
      10 + bonus_rolls(1, frames, idx)
    end

    def final_frame?(idx)
      idx == 9
    end

    def strike?(rolls)
      rolls.first == STRIKE && rolls.last.nil?
    end

    def spare?(rolls)
      rolls.first != STRIKE && rolls.sum == 10
    end

    def score_nonfinal(rolls, frames, idx)
      if strike?(rolls) then strike_with_bonus(frames, idx)
      elsif spare?(rolls) then spare_with_bonus(frames, idx)
      else rolls.sum # 通常の投球
      end
    end

    def score_for(frames)
      frames.each_with_index.sum do |rolls, i|
        final_frame?(i) ? rolls.sum : score_nonfinal(rolls, frames, i)
      end
    end
  end
end

puts Bowling::Game.new(ARGV[0]).score if __FILE__ == $PROGRAM_NAME
