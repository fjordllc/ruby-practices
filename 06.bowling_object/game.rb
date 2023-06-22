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
    total_point = 0
    @frames.each.with_index do |frame, index|
      break if index == 10

      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]

      total_point += calculate_frame_point(frame, next_frame, after_next_frame)
    end
    total_point
  end
end
