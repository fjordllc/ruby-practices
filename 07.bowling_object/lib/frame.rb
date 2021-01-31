# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark).roll_to_integer
    @second_shot = Shot.new(second_mark).roll_to_integer
    @third_shot = Shot.new(third_mark).roll_to_integer
  end

  def score
    [@first_shot, @second_shot, @third_shot].sum
  end

  def strike?
    @first_shot.equal?(10)
  end

  def spare?
    @first_shot + @second_shot == 10 && @first_shot != 10
  end
end
