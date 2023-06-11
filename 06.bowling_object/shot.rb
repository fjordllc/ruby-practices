# frozen_string_literal: true

class Shot
  attr_reader :shot_score

  def initialize(shot_score)
    @shot_score = shot_score
  end
end
