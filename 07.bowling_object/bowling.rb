#!/usr/bin/env ruby
# frozen_string_literal: true

module Bowling
  module Score
    class << self
      def strike_point = Strike.point

      def of(sym, rolls)
        bonus?(sym, rolls) && score_with_bonus_for(sym, rolls)
      end

      def bonus?(sym, rolls)
        bonus_type(sym).satisfied_by?(rolls)
      end

      private

      def score_with_bonus_for(sym, rolls)
        bonus_type(sym).score_for(rolls)
      end

      def bonus_type(sym)
        const_get(sym.to_s.capitalize)
      end
    end

    module Strike
      class << self
        def point = 10

        def satisfied_by?(rolls)
          rolls.roll(1) == Strike.point && rolls.roll(2).nil?
        end

        def score_for(rolls)
          point + rolls.bonus_point(roll_count: 2)
        end
      end
    end

    module Spare
      class << self
        def point = 10

        def satisfied_by?(rolls)
          !strike?(rolls) && rolls.sum == 10
        end

        def score_for(rolls)
          point + rolls.bonus_point(roll_count: 1)
        end

        private

        def strike?(rolls) = Score.bonus?(:strike, rolls)
      end
    end
  end

  class Rolls
    def initialize(rolls, frames, index)
      @rolls, @frames, @index = rolls, frames, index # rubocop:disable Style/ParallelAssignment
    end

    def score
      final_frame? ? sum : score_nonfinal
    end

    # 何投目かは1-3で指定する
    def roll(num) = rolls[num - 1]

    def sum = rolls.sum

    # 次フレーム以降の投球をcount数取得する。次フレームがストライクだった場合、
    # 2投目はnilなのでさらにその次のフレームの1投目を取得する
    def bonus_point(roll_count:)
      next_frame(1).take(roll_count).sum { |roll| roll || next_frame(2).roll(1) }
    end

    protected

    def take(count)
      rolls.take(count)
    end

    private

    attr_reader :rolls, :frames, :index

    def next_frame(count)
      frames[index + count]
    end

    def score_nonfinal
      score_if(:strike) || score_if(:spare) || open_frame
    end

    alias open_frame sum

    def final_frame?
      Game.final_frame?(index)
    end

    def score_if(sym)
      Score.of(sym, self)
    end
  end

  class Parse
    def self.call(marks)
      new.call(marks)
    end

    def call(marks)
      pins = pins_from(marks)
      Game.frame_size.times.with_object([]) do |i, frames|
        frames << create_rolls_for_frame(i, pins, frames)
      end
    end

    private

    def initialize; end

    def pins_from(marks)
      marks.split(',').map { |m| m == 'X' ? Score.strike_point : m.to_i }
    end

    def create_rolls_for_frame(index, pins, frames)
      Game.final_frame?(index) ? Rolls.new(pins, frames, index) : Rolls.new(pins_for_rolls!(pins), frames, index)
    end

    def pins_for_rolls!(pins)
      strike?(pins.first) ? [pins.shift, nil] : pins.shift(2)
    end

    def strike?(pin)
      pin == Score.strike_point
    end
  end

  class Game
    class << self
      def frame_size = 10

      def final_frame?(index) = (index == final_frame_idx)

      private

      def final_frame_idx = 9
    end

    def initialize(marks)
      @frames = Parse.call(marks)
    end

    def score
      frames.sum(&:score)
    end

    private

    attr_reader :frames
  end
end

puts Bowling::Game.new(ARGV[0]).score if __FILE__ == $PROGRAM_NAME
