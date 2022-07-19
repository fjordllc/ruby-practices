# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input)
    @frames = parse_input(split(input))
  end

  def score
    @frames.map.with_index do |frame, index|
      frame.score(@frames[index + 1], @frames[index + 2])
    end.sum
  end

  private

  def parse_input(input)
    frames = []
    9.times do
      pins = input.shift(2)
      if pins[0] == 'X'
        frames << Frame.new(pins[0])
        input.unshift(pins.last)
      else
        frames << Frame.new(pins[0], pins[1])
      end
    end
    frames << Frame.new(input[0], input[1], input[2])
    frames
  end

  def split(input)
    input.instance_of?(Array) ? input : input.split(',')
  end
end
