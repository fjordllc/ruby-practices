# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [@first_shot.to_num, @second_shot.to_num, @third_shot.to_num].sum
  end

  def shots
    if @second_shot.mark.nil? && @third_shot.mark.nil?
      [@first_shot.to_num]
    elsif @third_shot.mark.nil?
      [@first_shot.to_num, @second_shot.to_num]
    else
      [@first_shot.to_num, @second_shot.to_num, @third_shot.to_num]
    end
  end

  def strike?
    @first_shot.to_num == 10
  end

  def spare?
    @first_shot.to_num != 10 && @first_shot.to_num + @second_shot.to_num == 10
  end
end
