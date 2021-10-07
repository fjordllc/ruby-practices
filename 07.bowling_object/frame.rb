# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = nil, third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  class << self
    def divide(shots)
      frame = []
      divided_shots = []

      shots.each do |shot|
        frame << shot
        if divided_shots.size < 10
          if frame.size >= 2 || shot.numerate == 10
            divided_shots << frame.dup
            frame.clear
          end
        else
          divided_shots.last << shot
        end
      end

      divided_shots
    end

    def sum_next_first_two_shots(frame_one, frame_two)
      summing_shots = [frame_one.first_shot, frame_one.second_shot, frame_one.third_shot, frame_two.first_shot]
      summing_shots.compact.slice(0, 2).map(&:numerate).sum
    end
  end

  def sum
    [first_shot, second_shot, third_shot].compact.map(&:numerate).sum
  end
end
