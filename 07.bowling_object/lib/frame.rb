# frozen_string_literal: true

require './lib/shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    if strike?
      10 + [second_shot.score, third_shot.score].sum
    elsif spare?
      10 + third_shot.score
    else
      [first_shot.score, second_shot.score].sum
    end
  end

  def strike?
    first_shot.score == 10
  end

  def spare?
    !strike? && [first_shot.score, second_shot.score].sum == 10
  end
end

