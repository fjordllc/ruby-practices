#!/usr/bin/env ruby
# frozen_string_literal: true

class Bowling
  def play
    first_throws  = []
    second_throws = []
    bonuses       = []
    throw_index   = 0
    throws        = ARGV[0].split(',')

    10.times do
      if throws[throw_index] == 'X'
        first_throws.push(10)
        second_throws.push(0)
        bonus1 = throws[throw_index + 1] == 'X' ? 10 : throws[throw_index + 1].to_i
        bonus2 = throws[throw_index + 2] == 'X' ? 10 : throws[throw_index + 2].to_i
        bonuses.push(bonus1 + bonus2)
        throw_index += 1
      else
        first_throws.push(throws[throw_index].to_i)
        second_throws.push(throws[throw_index + 1].to_i)
        if throws[throw_index].to_i + throws[throw_index + 1].to_i == 10
          bonus = throws[throw_index + 2] == 'X' ? 10 : throws[throw_index + 2].to_i
          bonuses.push(bonus)
        else
          bonuses.push(0)
        end
        throw_index += 2
      end
    end
    puts first_throws.sum + second_throws.sum + bonuses.sum
  end
end

bowling = Bowling.new
bowling.play
