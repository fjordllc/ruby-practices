# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score

  def initialize(first_score, second_score = nil)
    @first_score = Shot.new(first_score).score
    @second_score = Shot.new(second_score).score
  end

  def score
    @first_score + @second_score
  end
end
