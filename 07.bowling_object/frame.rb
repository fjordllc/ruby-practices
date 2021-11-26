# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
    @shots = [@first_shot, @second_shot, @third_shot]
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    first_shot.score == 10
  end

  def spare?
    score == 10
  end
end
