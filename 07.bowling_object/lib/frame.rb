# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark).score
    @second_shot = Shot.new(second_mark).score
    @third_shot = Shot.new(third_mark).score
  end

  def sum_shots
    [@first_shot, @second_shot, @third_shot].sum
  end

  def strike?
    @first_shot == 10
  end

  def spare?
    [@first_shot, @second_shot].sum == 10
  end
end
