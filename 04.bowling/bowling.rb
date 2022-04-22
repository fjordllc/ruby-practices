#!/usr/bin/env ruby
# frozen_string_literal: true

class Bowling
  def initialize
    @first_throws  = []
    @second_throws = []
    @bonuses       = []
    @throw_index   = 0
    @throws        = ARGV[0].split(',')
  end

  def score(first_throw:, second_throw:, bonus:)
    @first_throws.push(first_throw)
    @second_throws.push(second_throw)
    @bonuses.push(bonus)
  end

  def judge_strike(next_throw_index)
    @throws[@throw_index + next_throw_index] == 'X' ? @first_strike_score : @throws[@throw_index + next_throw_index].to_i
  end

  def play
    @first_strike_score  = 10
    @second_strike_score = 0
    @spare_score         = 10
    @no_bonus            = 0

    10.times do
      if @throws[@throw_index] == 'X'
        score(first_throw: @first_strike_score, second_throw: @second_strike_score, bonus: judge_strike(1) + judge_strike(2))
        @throw_index += 1
      else
        bonus = @throws[@throw_index].to_i + @throws[@throw_index + 1].to_i == @spare_score ? judge_strike(2) : @no_bonus
        score(first_throw: @throws[@throw_index].to_i, second_throw: @throws[@throw_index + 1].to_i, bonus: bonus)
        @throw_index += 2
      end
    end
    puts @first_throws.sum + @second_throws.sum + @bonuses.sum
  end
end

bowling = Bowling.new
bowling.play
