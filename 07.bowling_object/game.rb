# frozen_string_literal: true

class Game
  attr_reader :frames

  def initialize(frames)
    @frames = frames
  end

  def score
    point = 0

    (0..9).each do |count|
      frame, next_frame, after_next_frame = frames.slice(count, 3)
      next_frame ||= []
      after_next_frame ||= []
      left_shots = next_frame + after_next_frame

      point += if frame[0] == 10
                 frame.sum + left_shots.slice(0, 2).sum
               elsif frame.sum == 10
                 frame.sum + left_shots.fetch(0)
               else
                 frame.sum
               end
    end

    point
  end
end
