# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :first_shot, :second_shot

  def initialize(first_shot, second_shot)
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
  end

  # 10フレーム以降もこれにあてはまる
  def calc_normal_frame
    @first_shot.mark + @second_shot.mark
  end

  def calc_strike_frame

  end

  def calc_spare_frame

  end
end


