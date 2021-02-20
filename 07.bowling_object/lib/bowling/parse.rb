# frozen_string_literal: true

module Bowling
  class Parse
    def self.call(marks)
      new(marks).call
    end

    def call
      Game.frame_size.times.with_object(@frames) { |i, f| f[i] = rolls_for_frame(i) }
    end

    private

    def initialize(marks)
      @marks = marks
      @frames = []
    end

    def pins
      @pins ||= @marks.split(',').map { |m| m == 'X' ? Score.strike_point : m.to_i }
    end

    def rolls_for_frame(index)
      Game.final_frame?(index) ? Rolls.new(pins, @frames, index) : Rolls.new(pins_for_rolls!, @frames, index)
    end

    def pins_for_rolls!
      # TODO: ストライク2投目のnilは無くせるのでは… :thinking_face:
      strike?(pins.first) ? [pins.shift, nil] : pins.shift(2)
    end

    def strike?(pin)
      pin == Score.strike_point
    end
  end
end
