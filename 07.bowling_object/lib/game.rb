# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(scores)
    @frames = Frame.generate_frames(scores)
  end

  def calc_scores
    @frames.each.sum do |frame|
      if frame.strike? && frame.index < 9
        frame.sum_shots + frame.strike_bonus(@frames, frame.index)
      elsif frame.spare? && frame.index < 9
        frame.sum_shots + frame.spare_bonus(@frames, frame.index)
      else
        frame.sum_shots
      end
    end
  end
end
