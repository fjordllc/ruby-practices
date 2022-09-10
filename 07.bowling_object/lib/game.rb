# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(scores)
    @frames = Frame.generate_frames(scores)
  end

  def calc_scores
    @frames.each.sum do |frame|
      frame.score(@frames, frame)
    end
  end
end
