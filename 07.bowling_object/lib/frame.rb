# frozen_string_literal: true

class Frame
  attr_reader :frame_number, :first_shot, :second_shot, :third_shot

  def initialize(frame_number, shots)
    @frame_number = frame_number
    # 2投目と3投目を投げていない場合は、倒したピン数を0にしておく
    shots << 0 while shots.length < 3
    @first_shot, @second_shot, @third_shot = shots.map { |shot| Shot.new(shot) }
  end

  def number_of_pins
    @first_shot.pins + @second_shot.pins + @third_shot.pins
  end

  def strike?
    @first_shot.pins == 10
  end

  def spare?
    @first_shot.pins + @second_shot.pins == 10
  end
end
