# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(argument)
    shots = []
    argument.split(',').each do |s|
      if s == 'X'
        shots << s
        shots << 0
      else
        shots << s
      end
    end

    frames = shots.each_slice(2).to_a
    @frames = frames.map { |frame| Frame.new(*frame) }
  end

  def score
    @frames.each.with_index.sum do |frame, index|
      next 0 if index == 10

      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]
      frame.score(next_frame, after_next_frame)
    end
  end
end
