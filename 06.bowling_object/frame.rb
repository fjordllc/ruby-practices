# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score

  def initialize(first_score, second_score = nill)
    @first_score = Shot.new(first_score).shot_score
    @second_score = Shot.new(second_score).shot_score
  end

  def frame_score
    @first_score + @second_score
  end
end
