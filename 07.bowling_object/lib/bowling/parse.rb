# frozen_string_literal: true

module Bowling
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
      # TODO: ストライク2投目のnilは無くせるのでは… :thinking_face:
      strike?(pins.first) ? [pins.shift, nil] : pins.shift(2)
    end

    def strike?(pin)
      pin == Score.strike_point
    end
  end
end
